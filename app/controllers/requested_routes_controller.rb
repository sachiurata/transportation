class RequestedRoutesController < ApplicationController
  def index
  end

  def new
    @requested_route = RequestedRoute.new
    # URLのchild_idから対象のお子様を特定
    @child = Child.find_by(id: params[:child_id])
    # お子様が見つからない場合はマイページに戻す
    unless @child
      redirect_to user_path(current_user), alert: "対象のお子さんが見つかりません。"
    end
  end

  def create
    # subject_id と subject_type をマージして、どのオブジェクトに関連付くかを指定
    @requested_route = RequestedRoute.new(requested_route_params.merge(subject_type: "Child"))
    if @requested_route.save
      redirect_to root_path, notice: "送信完了"
    else
      # エラー時に@childを再設定して、newテンプレートを正しく表示する
      @child = current_user.children.find_by(id: requested_route_params[:subject_id])
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def requested_route_params
    params.require(:requested_route).permit(
      :child_id,
      :start_point_location,
      :end_point_location,
      :is_existing_service_available,
      :start_point_name,
      :end_point_name,
      :subject_id,
      :subject_type,
      requested_times_attributes: [ :id, :requested_day, :requested_time, :departure_or_arrival, :_destroy ]
    )
  end
end
