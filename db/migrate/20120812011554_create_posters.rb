class CreatePosters < ActiveRecord::Migration
  def up
    create_table :posters do |t|
      t.string :name
    end
  end

  def down
    drop_table :posters
  end
end
