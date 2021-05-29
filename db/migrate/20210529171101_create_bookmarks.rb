class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :product, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
    end
  end
end
