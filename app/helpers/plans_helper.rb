module PlansHelper
  def date_class(plan)
    plan.important? ? 'teal-text darken-3' : 'grey-text darken-3'
  end

  def events(plan)
    plan.events.join(', ')
  end
end
