class AddZipcodeToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :zipcode, :string
  end
end
