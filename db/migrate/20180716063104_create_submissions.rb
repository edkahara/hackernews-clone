class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :url
      t.integer :user_id

      t.timestamps
    end
    add_index :submissions, :user_id
  end
end
