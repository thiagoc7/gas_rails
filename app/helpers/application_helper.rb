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
    number_with_delimiter(number, delimiter: ".")
  end
end
