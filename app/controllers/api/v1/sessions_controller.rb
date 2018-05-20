class Api::V1::SessionsController < ApplicationController
# before_action :authorized, only: [:show]

  def show
    #if #saying if this current_user exists, send me back user data
    render json: current_user.id

  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      payload = {user_id: user.id}
      token = issue_token(payload)
      render json: { jwt: token, yay: true, user: user }.to_json, status: 200
    else
      render json: { error: "bad"}
    end
  end


end
