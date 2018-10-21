class BankController < ApplicationController

	def list
      @banks = Bank.all
   end

   def show
     begin 
      @bank = Bank.find(params[:id])
      render json: {bank: bank}, status: :ok
     rescue ActiveRecord::RecordNotFound => e
      render json: {errors: bank.e.message}, status: :unprocessable_entity
     end 
   end
  
   def new
      @bank = Bank.new
      @users = User.all
      render json: {bank: bank}, status: :ok
   end

   def bank_params
      params.require(:banks).permit(:name, :address)
   end

   def create
      @bank = Bank.new(bank_params)

      if @bank.save
         redirect_to :action => 'list'
         render json: {bank: bank}, status: :ok
      else
         @users = User.all
         render json: {errors: bank.errors.full_messages}, status: :unprocessable_entity
      end
   end
   
   def edit
      @bank = Bank.find(params[:id])
      @users = User.all
      render json: {bank: bank}, status: :ok
   end
   
   def update
      @bank = Bank.find(params[:id])
      
      if @bank.update_attributes(bank_param)
         redirect_to :action => 'show', :id => @bank
         render json: {bank: bank}, status: :ok
      else
         @users = User.all
         render :action => 'edit'
         render json: {error: bank.e.message}, status: :unprocessable_entity
      end
   end
   
   def delete
      Bank.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {bank: bank}, status: :ok
   end
   
   def show_users
      @user = User.find(params[:id])
   end

end