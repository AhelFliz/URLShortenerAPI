class ShortensController < ApplicationController
  before_action :set_shorten, only: %i[ update show stats destroy ]

  def create
    @shorten = Shorten.new(shorten_params)

    if @shorten.save
      render json: @shorten, status: 200
    else
      render json: { errors: @shorten.errors.full_message }, status: :unproccesable_entity
    end
  end

  def show
    @shorten.increment!(:access_count)
    redirect_to @shorten.url, allow_other_host: true
  end

  def stats
    render json: @shorten.access_count
  end

  def update
    if @shorten.update(shorten_params)
      render json: @shorten
    else
      render json: { errors: @shorten.errors.full_message }, status: :unproccesable_entity
    end
  end

  def destroy
    @shorten.destroy
    head :no_content
  end

  private

  def set_shorten
    @shorten = Shorten.find_by(short_code: params[:id])
    render json: { error: "Not found" }, status: :not_found unless @shorten
  end

  def shorten_params
    params.require(:shorten).permit(:url)
  end
end
