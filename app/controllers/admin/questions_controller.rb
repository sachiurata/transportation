class Admin::QuestionsController < Admin::BaseController
  before_action :set_survey

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

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
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
