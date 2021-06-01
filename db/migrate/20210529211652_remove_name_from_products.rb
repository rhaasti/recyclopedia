class RemoveNameFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :name, :string
  end
end
