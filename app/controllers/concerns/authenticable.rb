# app/controllers/concerns/authenticable.rb
module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user! 
  end

  private
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token.nil?
      Rails.logger.warn "Authentication failed: Missing token"
      return render_unauthorized("Missing token")
    end


    # @token = JsonWebToken.decode(token)
    #  return render_unauthorized("Missing token") if token.nil?
     
    # @current_user = User.find_by(id: @token.id) if @token


     begin
        @token = JsonWebToken.decode(token)
       @current_user = User.find_by(id: @token.id) if @token
if @current_user.nil?
        Rails.logger.warn "Authentication failed: User not found for ID #{@token.id}"
        return render_unauthorized("Invalid token. User not found.")
      end

    # rescue JWT::ExpiredSignature
    #   render_unauthorized("Session expired. Please log in again.")
    # rescue JWT::DecodeError
    #   render_unauthorized("Invalid token. Please log in again.")
    # end

rescue JWT::ExpiredSignature
      Rails.logger.warn "Authentication failed: Token expired"
      render_unauthorized("Session expired. Please log in again.")
    rescue JWT::DecodeError => e
      Rails.logger.warn "Authentication failed: #{e.message}"
      render_unauthorized("Invalid token. Please log in again.")
    rescue StandardError => e
      Rails.logger.error "Unexpected error in authenticate_user!: #{e.message}"
      render json: { error: "Internal Server Error" }, status: :internal_server_error
    end

    #  render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end
