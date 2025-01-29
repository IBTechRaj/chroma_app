# module Api
  # module V1
    class UsersController < ApplicationController
      # before_action :set_user, only: [:show, :update, :destroy]
    

  #     def index
  #       # @users = User.all
  #       users = User.all.map do |user|
  #   {
  #     id: user.id,
  #     name: user.name,
  #     email: user.email,
  #     role: user.role,
  #     profile_pic_url: user.profile_pic
  #   }
  # end
  #       render json: users, status: :ok
  #     end

      def index
          @users = User.all
    render json:  @users.map { |user|
    UserSerializer.new(user).serializable_hash[:data][:attributes]
    }
    end
      
      # def create
      #   @user = User.new(user_params)
      #   if @user.save!
      #     render json: { message: 'User created successfully' }, status: :created
      #   else
      #     puts  @user.errors.full_messages
      #     render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      #   end
      # end

      def login
        query_email = params[:email].downcase
        user = User.find_by_email(query_email)
        if user && user.authenticate(params[:password]) # Verify password
          token = encode(user.id) # Generate JWT for the user
          render json: { message: 'Logged in successfully', token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    
def create
      query_email = params[:email].downcase
      account = User.where('LOWER(email) = ?', query_email).first
      validator = EmailValidation.new(params[:email])
      return render json: {errors:   'Email invalid or Already Taken' }, status: :unprocessable_entity if account || !validator.valid?

      @user = User.new(user_params)
      # @client_url = request.headers[:origin] || 'Client Url Missing' 
    
      if @user.save!
        # StudentEmailVerificationMailer.student_email_verification(@student, request.base_url, @client_url).deliver_now!
        # AdminEmailAlertsMailer.admin_email_alerts(@student).deliver_now
        render json: UserSerializer.new(@user, meta: {
          token: encode(@user.id), message: "User created successfully"
        }).serializable_hash, status: :ok
      else
        render json: {errors: format_activerecord_errors(@user.errors)},
          status: :unprocessable_entity
      end
    end


      def logout
    # Simply respond with success (optional: log this action)
        render json: { message: 'Logged out successfully' }, status: :ok
      end
  
 def current_user
    # byebug
    token = request.headers['Authorization']&.split(' ')&.last
    #  puts 't'
    #  puts  Rails.logger.info "Extracted Token: #{token}" 
      @token = JsonWebToken.decode(token)
      @user = User.find_by(id: @token.id)
      if @user.present?
        render json: UserSerializer.new(@user, meta: {
          token: encode(@user.id), message: "User fetched successfully"
        }).serializable_hash, status: :ok
      # render json: {
      #   id: @user.id,
      #   name: @user.name,
      #   email: @user.email,
      #   role: @user.role,
      #   profile_pic_url: @user.profile_pic
      #   # Add any other fields you want to expose
      # }, status: :ok
    else
      render json: { error: 'No current user' }, status: :unauthorized
    end
  end
      # if user
      #   if user.authenticate(params[:password])
           
      #       render json: User.new(user, meta: {
      #         token: encode(user.id),
      #       }).serializable_hash, status: :created
      #   else
      #     render json: { errors: 'Invalid email or password'}, status: :unprocessable_entity
      #   end
        
      # else
      #   render json: { errors: 'Invalid email or password'}, status: :unprocessable_entity
      # end
      # end   
def show
        render json: @user
      end

      def update
        if @user.update(user_params)
          render json: { message: 'User updated successfully' }, status: :updated
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      
      private

      def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

      def encode(id)
        JsonWebToken.encode id
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(:name, :email, :role, :password, :password_confirmation, :profile_pic)
      end
        
      # def user_params
      #   params.require(:user).permit(:name, :email, :role, :password, :password_confirmation, :profile_pic)
      # end

    end
  # end
# end