class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :parent_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
    add_index :comments, :parent_id
    add_index :comments, :user_id
  end
end
