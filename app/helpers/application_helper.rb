module ApplicationHelper
  def format(number)
    return nil unless number
    return l number, format: :long if number.is_a? Date
    return number if number.is_a? String
    number_with_delimiter(number.round(-2), delimiter: ".")
  end

  def format_small(number)
    return l number, format: :short if number.is_a? Date
    format number
  end

  def format_real(number)
    number_with_delimiter(number.round, delimiter: ".")
  end

  def cache_key_for_plans(plans, suffix = '')
    ids = plans.map(&:id).join('-')
    max_updated_at = plans.map(&:updated_at).max
    "plans/#{ids}-#{max_updated_at.to_i}#{suffix}"
  end
end
