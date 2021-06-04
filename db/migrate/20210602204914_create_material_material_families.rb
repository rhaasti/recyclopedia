class CreateMaterialMaterialFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :material_material_families do |t|
      t.references :material_family, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true

      t.timestamps
    end
  end
end
