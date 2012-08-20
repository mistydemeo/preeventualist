module Responses
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
end