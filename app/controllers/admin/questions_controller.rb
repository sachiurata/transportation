class Admin::QuestionsController < Admin::BaseController
  before_action :set_survey
  # edit, update, destroy アクションの前に @question をセットする
  before_action :set_question, only: [ :edit, :update, :destroy ]

  # GET /admin/surveys/:survey_id/questions
  def index
    @questions = @survey.questions.order(created_at: :asc)
  end

  # GET /admin/surveys/:survey_id/questions/new
  def new
    @question = @survey.questions.build
    10.times { @question.question_options.build }
  end

  # POST /admin/surveys/:survey_id/questions
  def create
    @question = @survey.questions.build(question_params)
    if @question.save
      flash[:success] = "質問を追加しました。"
      # 成功したら、続けて次の質問を登録できるよう、再度newへリダイレクト
      redirect_to new_admin_survey_question_path(@survey)
    else
      flash.now[:danger] = "質問の追加に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 選択肢がない場合に備えて、空の入力欄をいくつか用意しておく
    (10 - @question.question_options.count).times { @question.question_options.build } if @question.question_options.count < 10
  end

  def update
    if @question.update(question_params)
      flash[:success] = "質問を更新しました。"
      redirect_to admin_survey_questions_path(@survey)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "質問を削除しました。"
    redirect_to admin_survey_questions_path(@survey), status: :see_other
  end


  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question
    @question = @survey.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :text,
      :question_type,
      :display_order,
      question_options_attributes: [ :id, :text, :_destroy ]
    )
  end
end
