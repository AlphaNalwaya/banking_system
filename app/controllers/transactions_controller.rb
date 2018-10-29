class TransactionController < ApplicationController
  skip_before_action :verify_authenticity_token
  
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
     respond_to do |format|
       format.html{}
        format.json {render json: { transaction: @transaction }, status: :ok}
     end   
   end

   def transaction_params
      params.require(:transactions).permit(:amount, :operation, :account, :debit_card)
   end

   def create
     @transaction = Transaction.new(transaction_params)
     if @transaction.save
       render json: { transaction: @transaction }, status: :created
     else
       render json: { errors: @transaction.errors }, status: :unprocessable_entity
    end

   end

   def destroy
      @transaction = Transaction.find(params[:id])
      respond_to do |render|
      @transaction.destroy
      render.json { render json: {}, status: :ok }
     rescue ActiveRecord::RecordNotFound => e
      respond_to do |render|
      render.json { render json: { error: e.message }, status: :unprocessable_entity }
     end
   end

   def index
     @transactions = Transaction.all
     render json: { transactions: @transactions }, status: :ok
   end
   
   def edit
     @transaction = Transaction.find(params[:id])
     respond_to do |format|
       format.html{}
        format.json {render json: { transaction: @transaction }, status: :ok}
     end
   rescue ActiveRecord::RecordNotFound => e
     render json: { error: e.message }, status: :not_found
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