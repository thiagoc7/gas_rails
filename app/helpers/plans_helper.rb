module PlansHelper
  def date_class(plan)
    plan.important? ? 'light-green-text darken-1' : 'grey-text darken-3'
  end

  def events(plan)
    plan.events.join(', ')
  end
end
