class Post < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :poster_id
  validates_presence_of :created_on

  belongs_to :poster, :class_name => "Poster", :inverse_of => :posts
end