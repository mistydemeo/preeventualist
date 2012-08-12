class Poster < ActiveRecord::Base
  validates_presence_of :name

  has_many :posts, :class_name => "Post", :inverse_of => :poster
end