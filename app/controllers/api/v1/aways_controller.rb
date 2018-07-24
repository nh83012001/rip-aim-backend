class Api::V1::AwaysController < ActionController::API
  def index
    @aways = Away.all
    render json: @aways
  end

  def create
    @away = Away.new(away_params)
    @away.save
    render json: @away
  end

  def show
    @away = Away.find(params[:id])
    render json: @away
  end

  def update
    @away = Away.find(params[:id])
    @away.update(away_params)
  end

  def destroy
    @away = Away.find(params[:id])
    @away.destroy
  end

  private

    def away_params
      params.require(:away).permit(:user_id, :message)
    end
end
