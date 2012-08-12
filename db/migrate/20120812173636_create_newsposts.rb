# This populates the database with newsposts
# These are canned because every newspost has already been written!

require "preeventualist/newsposts"

class CreateNewsposts < ActiveRecord::Migration
  def up
    perry = Poster.new name: "perry"
    perry.save
    Newsposts.each do |contents|
      post = perry.posts.new contents
      post.save
    end
  end

  def down
    Post.all.each(&:delete)
    Poster.all.each(&:delete)
  end
end
