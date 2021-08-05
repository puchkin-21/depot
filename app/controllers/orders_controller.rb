class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.order(:created_at).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :@orders}
    end
  end

  def show
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.json {render json: @order}
    end
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.recevied(@order).deliver
        format.html { redirect_to store_url, notice: I18n.t('thanks') }
        format.json { render :@order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :adress, :email, :pay_type)
    end
    
end