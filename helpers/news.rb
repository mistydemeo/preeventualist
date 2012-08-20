module NewsHelpers
  # Formats each newspost in this format with a 1-space indent,
  # as seen in the Poignant Guide:
  # /  dd month year /
  # text...
  #                                                    - salutation, poster
  def newspost_string post; <<-EOS
 / #{post.created_on.strftime("%d %B %Y")} /
#{post.text.each_line.map {|l| l.prepend " "}.join}
#{" " * 49} - #{post.salutation+", " if post.salutation}#{post.poster.name}
    EOS
  end

  def display_newsposts
    Post.limit(10).reverse.map {|p| newspost_string p}.join "\n"
  end
end