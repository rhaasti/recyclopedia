class ChangeUpcToBeStringInProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :UPC, :string
  end
end
