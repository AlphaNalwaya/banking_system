class LoanController < ApplicationController

	def list
      @loans = Loan.all
   end

   def show
     begin
      @loan = Loan.find(params[:id])
      render json: {loan: loan}, status: :ok  
     rescue ActiveRecord::RecordNotFound => e
      render json: {errors: loan.e.message}, status: :unprocessable_entity  
     end 
   end
  
   def new
      @loan = Loan.new
      @users = User.all
      render json: {loan: loan}, status: :ok
   end

   def loan_params
      params.require(:loans).permit(:loan_type, :amount, :interest_rate, :user_id)
   end

   def create
      @loan = Loan.new(loan_params)

      if @loan.save
         redirect_to :action => 'list'
         render json: {loan: loan}, status: :ok
      else
         @users = User.all
         render json: {errors: account.errors.full_messages}, status: :unprocessable_entity
      end
   end
   
   def edit
      @loan = Loan.find(params[:id])
      @users = User.all
      render json: {loan: loan}, status: :ok
   end
   
   def update
      @loan = Loan.find(params[:id])
      
      if @loan.update_attributes(loan_param)
         redirect_to :action => 'show', :id => @loan
         render json: {loan: loan}, status: :ok
      else
         @users = Loan.all
         render :action => 'edit'
         render json: {errors: account.errors.full_messages}, status: :unprocessable_entity
      end
   end
   
   def delete
      Loan.find(params[:id]).destroy
      redirect_to :action => 'list'
      render json: {loan: loan}, status: :ok
   end
   
   def show_users
      @User = User.find(params[:id])
   end

end