class AddAuthor < ActiveRecord::Migration
  def change
    add_column :posts, :author_id, :integer, null: false
  end
end
