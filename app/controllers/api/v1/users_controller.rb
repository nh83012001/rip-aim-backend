class Api::V1::UsersController < ActionController::API

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
     =  ENV["TWITTER_API_KEY"]
     =  ENV["TWITTER_API_SECRET"]
     =  ENV["TWITTER_API_ACCESS_TOKEN"]
     =  ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]

    @route = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@address}&key=#{@apiKey}"
    response = HTTParty.get(@route)

    render json: {current_user: @user}
  end

  def create
    @user = User.create(username: params[:username], password: params[:password], firstname: params[:firstname], lastname: params[:lastname] )
    render json: @user.to_json
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

  end

  private

  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :password )
  end
end
