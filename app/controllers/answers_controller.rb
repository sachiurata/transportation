class AnswersController < ApplicationController
  before_action :set_child
  before_action :set_survey, only: [ :new, :create, :edit, :update ]

  def new
    # TODO: どのアンケートに回答するかを動的に決める必要がある。一旦、最新のものを取得。
    @survey = Survey.last
    unless @survey
      redirect_to root_path, alert: "回答可能なアンケートがありません。"
      return
    end
    @questions = @survey.questions.includes(:question_options).order(:display_order)
  end

  def edit
    @questions = @survey.questions.includes(:question_options).order(:display_order)
    # 既存の回答を質問IDをキーにしたハッシュとして取得し、ビューで使いやすくする
    @existing_answers = @child.answers.includes(:answer_options).group_by(&:question_id)
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

  def update
    ActiveRecord::Base.transaction do
      # このお子さんの既存の回答を全て削除
      @child.answers.destroy_all
      # createアクションと同様のロジックで新しい回答を保存
      answers_params.each do |question_id, answer_data|
        answer = @child.answers.create!(question_id: question_id, free_text: answer_data[:free_text])
        if answer_data[:question_option_ids].present?
          answer_data[:question_option_ids].reject(&:blank?).each do |option_id|
            answer.answer_options.create!(question_option_id: option_id)
          end
        end
      end
    end
    redirect_to user_path(current_user), notice: "回答を更新しました。"
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "回答の更新に失敗しました。入力内容を確認してください。"
    @questions = @survey.questions.includes(:question_options).order(:display_order)
    render :edit, status: :unprocessable_entity
  end

  private

  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  # --- ここから set_survey アクションを追加 ---
  def set_survey
    # TODO: どのアンケートに回答するかを動的に決める必要がある。一旦、最新のものを取得。
    @survey = Survey.last
    unless @survey
      redirect_to root_path, alert: "回答可能なアンケートがありません。"
    end
  end
  # --- ここまで追加 ---

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
