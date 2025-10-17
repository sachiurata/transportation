class Admin::SurveysController < Admin::BaseController
  def index
    @surveys = Survey.all.order(created_at: :desc)
  end

  def show
    @survey = Survey.find(params[:id])
    @question = Question.new # 質問追加フォーム用の空のオブジェクト
    @questions = @survey.questions.order(created_at: :asc)
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = current_admin_user.surveys.build(survey_params)
    if @survey.save
      flash[:success] = "アンケートを作成しました。"
      redirect_to admin_survey_path(@survey)
    else
      flash.now[:danger] = "アンケートの作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:survey_name)
  end
end
