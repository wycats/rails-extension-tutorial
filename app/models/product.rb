#START:salable
#START:has_many
class Product < ActiveRecord::Base
  #START_HIGHLIGHT
  has_many :orders, :through => :line_items
  #END_HIGHLIGHT
  has_many :line_items
  # ...
#END:has_many

  def self.find_products_for_sale
    find(:all, :order => "title")
  end

  # validation stuff...
#END:salable


#START:validation
#START:val1
  validates_presence_of :title, :description, :image_url
#END:val1
#START:val2
  validates_numericality_of :price
#END:val2
#START:val2a
  validate :price_must_be_at_least_a_cent
#END:val2a
#START:val3
  validates_uniqueness_of :title
#END:val3
#START:val4
  validates_format_of :image_url,
                      :with    => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL for GIF, JPG ' +
                                  'or PNG image.'
#END:val4
#START:val2a

protected
  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 0.01') if price.nil? ||
                       price < 0.01
  end
#END:val2a
#END:validation

end
