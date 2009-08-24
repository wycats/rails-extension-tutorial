class Cart
  attr_reader :items   # <wtf linkend="wtf.attr.accessor">attr_reader</wtf>
  
  def initialize
    @items = []
  end
  
  #START:add_product
  def add_product(product)
    current_item = @items.find {|item| item.product == product}
    if current_item
      current_item.increment_quantity
    else
      current_item = CartItem.new(product)
      @items << current_item 
    end
    current_item
  end
  #END:add_product

  #START:total_price
  def total_price
    @items.sum { |item| item.price }
  end
  #END:total_price

  #START:total_items
  def total_items
    @items.sum { |item| item.quantity }
  end
  #END:total_items
end
