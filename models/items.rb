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

class LostItem < Items
  def initialize opts
    properties = {
      name:         opts["name"],
      item:         opts["item"],
      location:     opts["seen"],
      description:  opts["desc"],
      kind:         "lost",
      public_id:    Brooklynt.new.to_i
    }
    super properties
  end

  def self.where query
    query[:kind] = "lost"
    super query
  end
end

class FoundItem < Items
  def initialize opts
    properties = {
      name:         opts["name"],
      item:         opts["item"],
      location:     opts["at"],
      description:  opts["desc"],
      kind:         "found",
      public_id:    Brooklynt.new.to_i
    }
    super properties
  end

  def self.where query
    query[:kind] = "found"
    super query
  end
end