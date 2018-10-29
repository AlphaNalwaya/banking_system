class LoanController < ApplicationController
  skip_before_action :verify_authenticity_token

	def list
      @loans = Loan.all
   end

  def show
    @loan = Loan.find(params[:id])
    respond_to do |format|
      format.html{}
       format.json {render json: { loan: @loan }, status: :ok}
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end
  
  def new
    @loan = Loan.new
    respond_to do |format|
      format.html{}
       format.json {render json: { loan: @loan }, status: :ok}
    end
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
   
  def destroy
      @loan = Loan.find(params[:id])
      respond_to do |render|
      @loan.destroy
      render.json { render json: {}, status: :ok }
     rescue ActiveRecord::RecordNotFound => e
      respond_to do |render|
      render.json { render json: { error: e.message }, status: :unprocessable_entity }
     end
  end
    
  def index
    @loans = Loan.all
    render json: { loans: @loans }, status: :ok
  end

  def edit
    @loan = Loan.find(params[:id])
    respond_to do |format|
      format.html{}
       format.json {render json: { loan: @loan }, status: :ok}
     end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
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