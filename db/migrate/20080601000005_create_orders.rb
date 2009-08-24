class CreateOrders < ActiveRecord::Migration
  #START:up
  def self.up
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
#START_HIGHLIGHT
      t.string :pay_type, :limit => 10
#END_HIGHLIGHT

      t.timestamps
    end
  end
  #END:up

  def self.down
    drop_table :orders
  end
end
