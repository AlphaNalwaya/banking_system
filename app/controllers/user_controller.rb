class UserController < ApplicationController

def list
      @users = User.all
   end

   def show
     begin
      @User = User.find(params[:id])
      render json: {user: user}, status: :ok 
     rescue ActiveRecord::RecordNotFound => e
      render json: {errors: loan.e.message}, status: :unprocessable_entity  
     end 
   end
  
   def new
      @user = User.new
      @banks = Bank.all
      render json: {user: user}, status: :ok
   end

   def user_params
      params.require(:users).permit(:name, :address, :phone_no, :bank_id)
   end

   def create
      @User = User.new(user_params)

      if @user.save
         redirect_to :action => 'list'
         render json: {user: user}, status: :ok
      else
         @banks = Bank.all
         render json: {errors: loan.errors.full_message}, status: :unprocessable_entity
      end
   end
   
   def edit
      @user = User.find(params[:id])
      @banks = Bank.all
      render json: {user: user}, status: :ok
   end
   
   def update
      @user = User.find(params[:id])
      
      if @user.update_attributes(user_param)
         redirect_to :action => 'show', :id => @user
         render json: {user: user}, status: :ok
      else
         @banks = Bank.all
         render :action => 'edit'
         render json: {errors: loan.errors.full_message}, status: :unprocessable_entity
      end
   end
   
   def delete
      User.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {user: user}, status: :ok
   end
   
   def show_banks
      @bank = Bank.find(params[:id])
   end
      
end