class AnswersController < ApplicationController
  before_action :set_child

  def new
    # TODO: どのアンケートに回答するかを動的に決める必要がある。一旦、最新のものを取得。
    @survey = Survey.last
    unless @survey
      redirect_to root_path, alert: "回答可能なアンケートがありません。"
      return
    end
    @questions = @survey.questions.includes(:question_options).order(:display_order)
  end

  def create
    # トランザクションを使い、全ての回答が保存できる場合のみ実行する
    ActiveRecord::Base.transaction do
      answers_params.each do |question_id, answer_data|
        # 質問ごとにAnswerレコードを作成
        answer = @child.answers.create!(question_id: question_id, free_text: answer_data[:free_text])

        # 選択肢がある場合は、AnswerOptionも作成
        if answer_data[:question_option_ids].present?
          answer_data[:question_option_ids].reject(&:blank?).each do |option_id|
            answer.answer_options.create!(question_option_id: option_id)
          end
        end
      end
    end
    redirect_to user_path(current_user), notice: "アンケートにご協力いただき、ありがとうございました。"
  rescue ActiveRecord::RecordInvalid
    # 保存に失敗した場合は、フォームを再表示
    flash.now[:alert] = "回答の保存に失敗しました。入力内容を確認してください。"
    @survey = Survey.last
    @questions = @survey.questions.includes(:question_options).order(:display_order)
    render :new, status: :unprocessable_entity
  end

  private

  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def answers_params
    # パラメータのキー（質問ID）を全て取得する
    question_ids = params.require(:answers).keys

    # 取得したキーを元に、許可する属性のリストを動的に組み立てる
    permitted_keys = question_ids.map do |id|
      [ id, [ :free_text, { question_option_ids: [] } ] ]
    end.to_h

    params.require(:answers).permit(permitted_keys)
  end
end
