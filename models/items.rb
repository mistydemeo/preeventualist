class Items < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :item
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :kind

  def to_hash
    {
      :name        => name,
      :item        => item,
      :location    => location,
      :description => description,
      :kind        => kind
    }
  end
end