class CreateItems < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string :name
      t.string :item
      t.string :location
      t.string :description
      t.string :kind
    end
  end

  def down
    drop_table :items
  end
end
