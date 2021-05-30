class AddExternalIdToMaterials < ActiveRecord::Migration[6.0]
  def change
    add_column :materials, :external_id, :string
  end
end
