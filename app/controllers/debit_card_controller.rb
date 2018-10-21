class DebitCardController < ApplicationController

	def list
      @debit_cards = Debit_card.all
   end

   def show
     begin
      @debit_card = Debit_card.find(params[:id])
      render json: {debit_card: debit_card}, status: :ok
     rescue ActiveRecord::RecordNotFound => e
      render json: {errors: debit_card.e.message}, status: :unprocessable_entity    
      end 
   end
  
   def new
      @debit_card = Debit_card.new
      @accounts = Account.all
      render json: {debit_card: debit_card}, status: :ok
   end

   def debit_card_params
      params.require(:banks).permit(:card_no, :expiry_date, :issue_date, :pin_no, :account)
   end

   def create
      @debit_card = Debit_card.new(debit_card_params)

      if @debit_card.save
         redirect_to :action => 'list'
         render json: {debit_card: debit_card}, status: :ok
      else
         @accounts = Account.all
         render :action => 'new'
         render json: {errors: debit_card.errors.full_messages}, status: :unprocessable_entity
      end
   end
   
   def edit
      @debit_card = Debit_card.find(params[:id])
      @accounts = Account.all
      render json: {debit_card: debit_card}, status: :ok
   end
   
   def update
      @debit_card = Debit_card.find(params[:id])
      
      if @debit_card.update_attributes(debit_card_param)
         redirect_to :action => 'show', :id => @debit_card
         render json: {debit_card: debit_card}, status: :ok
      else
         @accounts = Debit_card.all
         render :action => 'edit'
         render json: {errors: debit_card.errors.full_messages}, status: :unprocessable_entity
      end
   end
   
   def delete
      Debit_card.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {debit_card: debit_card}, status: :ok
   end
   
   def show_accounts
      @account = Account.find(params[:id])
   end
   
end