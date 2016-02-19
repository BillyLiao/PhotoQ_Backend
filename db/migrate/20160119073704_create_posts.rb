class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :answer
      t.string :question
      t.string :user

      t.timestamps null: false
    end
  end
end
