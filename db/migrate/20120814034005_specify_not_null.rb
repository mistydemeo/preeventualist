class SpecifyNotNull < ActiveRecord::Migration
  def up
    [:name,:item,:location,:description,:kind,:public_id].each do |column|
      change_column :items, column, :string, :null => false
    end
    change_column :posts, :created_on, :datetime, :null => false
    change_column :posts, :poster_id, :integer, :null => false
    change_column :posts, :text, :text, :null => false
    change_column :posters, :name, :string, :null => false
  end

  def down
    [:name,:item,:location,:description,:kind,:public_id].each do |column|
      change_column :items, column, :string, :null => true
    end
    change_column :posts, :created_on, :datetime, :null => true
    change_column :posts, :poster_id, :integer, :null => true
    change_column :posts, :text, :text, :null => true
    change_column :posters, :name, :string, :null => true
  end
end
