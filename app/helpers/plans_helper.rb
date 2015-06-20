module PlansHelper
  def date_class(plan)
    plan.important? ? 'teal-text darken-3' : 'grey-text darken-3'
  end
end
