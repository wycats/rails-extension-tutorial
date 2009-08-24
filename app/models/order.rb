#START:has_many
#START:select
#START:validate
class Order < ActiveRecord::Base
  #END:has_many
  PAYMENT_TYPES = [
    #  Displayed       stored in db
    [ "Check",          "check" ],
    [ "Credit card",    "cc" ],
    [ "Purchase order", "po" ]
  ]

#END:validate
  # ...
  #END:select
  #START:validate
  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => 
    PAYMENT_TYPES.map {|disp, value| value}

  # ...
  #END:validate


  #START:has_many
  has_many :line_items
  #END:has_many

  #START:add_line_items_from_cart
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
  #END:add_line_items_from_cart
#START:has_many
end
#END:has_many
