class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def index
    @customers = Customer.all
    @customers = Customer.where(updated_at: 24.hours.ago..Time.now)
  end

  def new
  	@customer = Customer.new
  end

  def create
  	@customer = Customer.new(customer_params)
  	respond_to do |format|
  		if @customer.save
  			format.html { redirect_to @customer, notice: "User created successfully" }
  			format.json { render json: @customer, status: :created, location: @customer }
  		else
  			format.html { render action: 'new' }
  			format.json { render json: @customer.errors, status: :unprocessable_entity }
  		end
  	end
  end


  def show
  	@customer = Customer.find(params[:id])
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def update
  	@customer = Customer.find(params[:id])
  	respond_to do |format|
	  	if @customer.update(customer_params)
	  		format.html { redirect_to @customer, notice: 'user was successfully updated.'}
	  		format.json { render json: @customer, status: :created, location: @customer }
	  	else
	  		format.html { render action: "update" }
	  		format.json {render json: @customer.errors, status: :unprocessable_entity}
	  	 end
  	end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end
  
  private
  def customer_params
  	params.require(:customer).permit(:cust_id, :name, :description, :created_at, :updated_at)
  end
end
