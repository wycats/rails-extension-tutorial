#START:authorize
class StoreController < ApplicationController
#END:authorize
      #START:before_filter
      before_filter :find_cart, :except => :empty_cart
      #END:before_filter
  #START:index
  def index
    @products = Product.find_products_for_sale
  end
  #END:index


  #START:rti
  #START:add_to_cart
  def add_to_cart
    product = Product.find(params[:id])
    @current_item = @cart.add_product(product)
    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")
  end
  #END:add_to_cart

#START:cart
  #START:empty_cart
  #START:checkout
  def checkout
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  #END:checkout

  #START:save_order
  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
# START_HIGHLIGHT
      redirect_to_index(I18n.t('flash.thanks'))
# END_HIGHLIGHT
    else
      render :action => 'checkout'
    end
  end
  #END:save_order

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end
  #END:empty_cart

private

  #START:redirect_to_index
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end
  #END:redirect_to_index
  #END:rti

      #START:find_cart
      def find_cart
        @cart = (session[:cart] ||= Cart.new)
      end
      #END:find_cart
#END:cart

#START:authorize
  #...
protected

  def authorize
  end
end
#END:authorize
