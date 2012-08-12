class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.datetime :created_on
      t.integer  :poster_id
      t.text     :text
      t.string   :salutation
    end
  end

  def down
    drop_table :posts
  end
end
