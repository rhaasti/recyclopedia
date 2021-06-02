class AddLongDescriptionToMaterials < ActiveRecord::Migration[6.0]
  def change
    add_column :materials, :long_description, :text
  end
end
