require 'oauth'
require 'json'

class Api::V1::UsersController < ActionController::API
# RIGHT NOW THE CONSUMERS ARE SET TO MINE
  CONSUMER_KEY =  ENV["TWITTER_API_KEY"]
  CONSUMER_SECRET =  ENV["TWITTER_API_SECRET"]

  OA_TOKEN =  ENV["TWITTER_API_ACCESS_TOKEN"]
  OA_SECRET =  ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]

  BASE_URI = 'https://api.twitter.com/1.1/'

  def initialize
    @oauth_token = ENV["TWITTER_API_ACCESS_TOKEN"]
    @oauth_token_secret =  ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {site:'https://api.twitter.com', :scheme => :header })
    # token_hash = { oauth_token: => OA_TOKEN, oauth_token_secret: => OA_SECRET }
    token_hash = { :oauth_token => @oauth_token, :oauth_token_secret => @oauth_token_secret }
    @access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  end

  def query(method_name, path, options=nil)
    JSON.parse(@access_token.request(method_name, "#{BASE_URI}#{path}",options).body)
  end

  def home_line
    response = query(:get, 'statuses/home_timeline.json')
  end

  def messages
    response = query(:get, 'direct_messages/events/list.json')
  end

  def method_name

  end



  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])


    # @route = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@address}&key=#{@apiKey}"
    # response = HTTParty.get(@route)

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
