require './condition_checker'

class TotalPriceGreaterThan < ConditionChecker

  def check(total_price)
    total_price > @value
  end

end
