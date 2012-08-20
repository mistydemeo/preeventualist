helpers do
  def json_requested?
    params["format"] == "json"
  end

  def validate_limit
    if not (params["limit"] && params["limit"] < 100 && params["limit"] > 0)
      params["limit"] = 10
    end
  end

  def input_errors mode
    if ![:found, :lost].include? mode
      raise ArgumentError, "Invalid mode - only :found and :lost are valid"
    end

    required_fields = ["name", "desc", "item"]
    if mode == :found
      required_fields.concat ["at"]
    elsif mode == :lost
      required_fields.concat ["seen"]
    end

    required_fields.select do |field|
      not params[field]
    end
  end

  def invalid_query_response
    if not json_requested?
      "You need to specify a search query with \"?q=\"!"
    else
      {"errors" => [{"message" => "Missing input(s)", "code" => 400}, "missing" => ["q"]]}
    end
  end

  def invalid_input_response_for errors
    if not json_requested?
      erb :error, :locals => {:errors => errors}
    else
      {"errors" => [{"message" => "Missing input(s)", "code" => 400, "missing" => errors}]}
    end
  end

  def search_response_for results
    if not json_requested?
      # This doesn't return 404 since that would raise an exception
      # for _why's client, which didn't have exception handling
      return "No results found :(" if results.empty?

      # _why's version didn't have a public "kind" value
      # or any kind of ID number
      result = results.first.to_hash
      result.delete_if do |k,_|
        [:kind, :public_id].include? k
      end

      # _why's guide specifies only one result, with unnamed fields
      # separated by "--\n"
      content_type :text
      result.values.join("\n--\n")
    else
      content_type :json
      status 404 if results.empty?
      results.map(&:to_hash).to_json
    end
  end

  def submission_confirmation item
    status 200

    if not json_requested?
      content_type :text
      "Thanks for submitting your #{params["item"]}!"
    else
      content_type :json
      item.to_hash.to_json
    end
  end

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