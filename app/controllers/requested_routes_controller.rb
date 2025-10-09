class RequestedRoutesController < ApplicationController
  def index
  end

  def new
    @requested_route = RequestedRoute.new
    @children = current_user.children
  end

  def create
    child = current_user.children.find(params[:requested_route][:subject_id])
    @requested_route = child.requested_routes.build(requested_route_params.merge(subject_type: "Child"))

    if @requested_route.save
      redirect_to root_path, notice: "送信完了"
    else
      @children = current_user.children
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
