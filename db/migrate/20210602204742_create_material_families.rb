class CreateMaterialFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :material_families do |t|
      t.string :description
      t.string :external_id

      t.timestamps
    end
  end
end
