class AccountController < ApplicationController

   skip_before_action :verify_authenticity_token

	def list
      @accounts = Account.all
   end

   def show
     begin 
      @account = Account.find(params[:id])
      render json: {account: account}, status: :ok
     rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
     end 
   end
  
   def new
      @account = Account.new
      @users = User.all
      render json: {account: @account}, status: :ok 
   end

   def account_params
      params.require(:accounts).permit(:account_no, :balance, :category, :bank_id, :user_id)
   end

   def create
     begin
       @account = account.new(account_params)
       if @account.save
         render json: { account: @account}, status: :created 
       else
         render json: @account.errors, status: :unprocessable_entity 
       end
     rescue ActiveRecord::InvalidForeignKey => e        
      render json: {error:'Invalid Foreign Key'}, status: :unprocessable_entity        
     end
   end
   
   def edit
     begin
       @account = Account.find(params[:id])
       render json: {account:@account}, status: :ok 
     rescue ActiveRecord::RecordNotFound => e
       render json: {error:e.message}, status: :not_found 
     end
   end
   
   def update
      @account = Account.find(params[:id])
      
      if @account.update_attributes(account_param)
         redirect_to :action => 'show', :id => @account
         render json: {account:@account}, status: :ok
      else
         @users = User.all
         render :action => 'edit'
         render json: {error:e.message}, status: :not_found
      end
   end
   
   def delete
      Account.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {account: account}, status: :ok
   end
   
   def show_users
      @user = User.find(params[:id])
   end

end