class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :set_customer,  only: [:edit, :update, :destroy]

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
    @order = Order.new
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    set_customer
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @order
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
    if @order.update(order_params)
      flash.notice = "The order record was updated successfully."
      redirect_to @order
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


  def set_order
    @order = Order.find(params[:id])
  end

  def set_customer
    @customer = @order.customer
  end
  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:product_name, :product_count, :customer_id)
  end
end
