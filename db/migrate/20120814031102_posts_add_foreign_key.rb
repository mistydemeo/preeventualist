require 'foreigner'
Foreigner.load

class PostsAddForeignKey < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.foreign_key :posters, dependent: :delete
    end
  end

  def down
    change_table :posts do |t|
      t.remove_foreign_key :posters
    end
  end
end
