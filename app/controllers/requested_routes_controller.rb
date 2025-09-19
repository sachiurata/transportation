class RequestedRoutesController < ApplicationController
  def index
  end

  def new
    @requested_route = RequestedRoute.new
  end

  def create
    @requested_route = current_user.requested_routes.build(requested_route_params)

    if @requested_route.save
      redirect_to root_path, notice: "送信完了"
    else
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
      requested_times_attributes: [ :id, :requested_day, :requested_time, :departure_or_arrival, :_destroy ]
    )
  end
end
