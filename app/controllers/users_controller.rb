class UsersController < ApplicationController

def list
      @users = User.all
   end

   def show
     @user = User.find(params[:id])
     respond_to do |format|
       format.html{}
        format.json {render json: { user: @user }, status: :ok}
     end
   rescue ActiveRecord::RecordNotFound => e
     render json: { errors: e.message }, status: :not_found
   end
  
   def new
     @user = User.new
     respond_to do |format|
       format.html{}
        format.json {render json: { user: @user }, status: :ok}
     end
   end

   def user_params
      params.require(:users).permit(:name, :address, :phone_no, :bank_id)
   end

   def create
     @user = User.new(user_params)
     if @user.save
       render json: { user: @user }, status: :created
     else
       render json: { errors: @user.errors }, status: :unprocessable_entity
     end
   end

   def destroy
      @user = User.find(params[:id])
      respond_to do |render|
      @user.destroy
      render.json { render json: {}, status: :ok }
     rescue ActiveRecord::RecordNotFound => e
      respond_to do |render|
      render.json { render json: { error: e.message }, status: :unprocessable_entity }
     end
   end

   def index
     @users = User.all
     render json: { users: @users }, status: :ok
   end
   
   def edit
     @user = User.find(params[:id])
     respond_to do |format|
       format.html{}
        format.json {render json: { user: @user }, status: :ok}
     end
   rescue ActiveRecord::RecordNotFound => e
     render json: { error: e.message }, status: :not_found
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
 end     
end