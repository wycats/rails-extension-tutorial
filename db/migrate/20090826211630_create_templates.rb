class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.timestamps
      t.string :name, :prefix, :format, :locale, :handler
      t.boolean :partial, :default => false
      t.text :source
    end
  end

  def self.down
    drop_table :templates
  end
end
