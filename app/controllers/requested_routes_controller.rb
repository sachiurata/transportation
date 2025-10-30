class RequestedRoutesController < ApplicationController
  # `set_child`を`set_subject`に変更
  before_action :set_subject, only: [ :index, :new, :create ]
  before_action :set_requested_route, only: [ :edit, :update, :destroy ]

  def index
    @requested_routes = @subject.requested_routes.includes(:requested_times)
    @routes_data = @requested_routes.map do |route|
      {
        id: route.id,
        start_point: { lat: route.start_point_location.y, lng: route.start_point_location.x },
        end_point: { lat: route.end_point_location.y, lng: route.end_point_location.x },
        start_name: route.start_point_name,
        end_name: route.end_point_name
      }
    end
  end

  def new
    # @subjectに紐づく新しい経路オブジェクトを作成
    @requested_route = @subject.requested_routes.build
  end

  def edit
  end

  def create
    # @subjectに紐づけて経路を作成
    @requested_route = @subject.requested_routes.build(requested_route_params)
    # TODO: どのアンケート(survey_id)に紐付けるか決定する必要がある。
    @requested_route.survey = Survey.last # 仮で最新のアンケートに紐付け

    if @requested_route.save
      redirect_to user_path(current_user), notice: "移動経路を登録しました。"
    else
      # エラー時に new テンプレートを正しく表示するため @subject は before_action で設定済み
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @requested_route.update(requested_route_params)
      # 更新後も subject の情報を使って一覧ページにリダイレクト
      redirect_to requested_routes_path(subject_id: @requested_route.subject_id, subject_type: @requested_route.subject_type), notice: "移動経路を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    subject_id = @requested_route.subject_id
    subject_type = @requested_route.subject_type
    @requested_route.destroy
    redirect_to requested_routes_path(subject_id: subject_id, subject_type: subject_type), notice: "移動経路を削除しました。", status: :see_other
  end

  private

  # `set_child` を `set_subject` にリファクタリング
  def set_subject
    # パラメータの構造に合わせて、IDとタイプを取得する
    if params[:requested_route].present?
      # create, update アクションの場合 (フォームから)
      subject_type = params.dig(:requested_route, :subject_type)
      subject_id = params.dig(:requested_route, :subject_id)
    else
      # index, new アクションの場合 (URLから)
      subject_type = params[:subject_type]
      subject_id = params[:subject_id]
    end

    # 今は Child のみを想定するが、将来的に他のモデルも扱えるように拡張可能
    if subject_type == "Child"
      # current_user に紐づくお子さんであることを確認し、セキュリティを確保
      @subject = current_user.children.find_by(id: subject_id)
    end

    unless @subject
      redirect_to user_path(current_user), alert: "対象が見つかりません。"
    end
  end

  def set_requested_route
    # ログインユーザーのお子さんに紐づく経路のみを対象にし、セキュリティを確保
    @requested_route = RequestedRoute.where(subject_type: "Child", subject_id: current_user.children.pluck(:id)).find(params[:id])
  end

  def requested_route_params
    params.require(:requested_route).permit(
      :subject_id,
      :subject_type,
      :start_point_location,
      :end_point_location,
      :is_existing_service_available,
      :start_point_name,
      :end_point_name,
      requested_times_attributes: [ :id, :requested_day, :requested_time, :departure_or_arrival, :_destroy ]
    )
  end
end
