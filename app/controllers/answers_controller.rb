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
        answer = @child.answers.create!(question_id: question_id, free_text: answer_data[:text])

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
    # パラメータの形式: params.require(:answers).permit("1" => [:text, question_option_ids: []], "2" => ...)
    params.require(:answers).permit! # 簡単のためpermit!を使用。本番では要件に応じて厳密に設定。
  end
end
