#START:belongs_to
class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
#END:belongs_to

  def self.from_cart_item(cart_item)
    li = self.new
    li.product     = cart_item.product
    li.quantity    = cart_item.quantity
    li.total_price = cart_item.price
    li
  end

#START:belongs_to
end
#END:belongs_to
