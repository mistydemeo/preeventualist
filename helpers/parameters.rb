module ParameterHelpers
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
end