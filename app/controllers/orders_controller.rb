class OrdersController < ApplicationController
  before_action :set_customer,  only: [:create, :edit, :update, :destroy]
  before_action :set_order, only: [:edit, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    if Order.exists?(params[:id])
      @order = Order.find(params[:id])
    else
      redirect_to orders_url
    end
  end

  # GET /orders/new
  def new
  end

  # POST /orders
  def create
    @order = @customer.orders.create(order_params)
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @customer
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(customer_params)
      flash.notice = "The customer record was updated successfully."
      redirect_to @customer
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:customer])
  end

  def set_order
    @order = @customer.orders.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:product_name, :product_count, :customer)
  end
end
