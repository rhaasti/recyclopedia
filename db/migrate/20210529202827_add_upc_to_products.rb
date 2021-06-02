class AddUpcToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :UPC, :integer
  end
end
