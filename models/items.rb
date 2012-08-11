class Items < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :item
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :kind
  validates_presence_of :public_id

  def to_hash
    {
      :name        => name,
      :item        => item,
      :location    => location,
      :description => description,
      :kind        => kind,
      :public_id   => public_id
    }
  end
end