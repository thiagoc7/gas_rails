module ApplicationHelper
  def format(number)
    return l number, format: :long if number.is_a? Date
    number_with_delimiter(number.round(-2), delimiter: ".")
  end

  def format_real(number)
    number_with_delimiter(number, delimiter: ".")
  end
end
