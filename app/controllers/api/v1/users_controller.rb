module Api
  module V1
    class UsersController < ApplicationController
      # before_action :set_user, only: [:show, :update, :destroy]
    

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def create
        # byebug
        @user = User.new(user_params)
        # puts 'u'
        # puts user_params
        # puts @user

        if @user.save!
          render json: { message: 'User created successfully' }, status: :created
        else
          puts  @user.errors.full_messages
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
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

      

      def set_user
        @user = User.find(params[:id])
      end

      # def user_params
      #   params.permit(:name, :email, :password, :password_confirmation, :profile_pic)
      # end
        
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_pic)
      end
    end
  end
end