class TransactionController < ApplicationController

	def list
      @transactions = Transaction.all
   end

   def show
     begin
      @transaction = Transaction.find(params[:id])
      render json: {transaction: transaction}, status: :ok  
     rescue ActiveRecord::RecordNotFound => e
      render json: {errors: transaction.e.message}, status: :unprocessable_entity    
      end 
      
   end
  
   def new
      @transaction = Transaction.new
      @accounts = Account.all
      render json: {transaction: transaction}, status: :ok
   end

   def transaction_params
      params.require(:transactions).permit(:amount, :operation, :account, :debit_card)
   end

   def create
      @transaction = Transaction.new(transaction_params)

      if @transaction.save
         redirect_to :action => 'list'
         render json: {transaction: transaction}, status: :ok
      else
         @accounts = Account.all
         render json: {errors: transaction.errors.full_message}, status: :unprocessable_entity
      end
   end
   
   def edit
      @transaction = Transaction.find(params[:id])
      @accounts = Account.all
      render json: {transaction: transaction}, status: :ok
   end
   
   def update
      @transaction = Transaction.find(params[:id])
      
      if @transaction.update_attributes(transaction_param)
         redirect_to :action => 'show', :id => @transaction
         render json: {transaction: transaction}, status: :ok
      else
         @accounts = Transaction.all
         render :action => 'edit'
         render json: {errors: transaction.errors.full_message}, status: :unprocessable_entity
      end
   end
   
   def delete
      Transaction.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {transaction: transaction}, status: :ok
   end
   
   def show_accounts
      @account = Account.find(params[:id])
   end

end