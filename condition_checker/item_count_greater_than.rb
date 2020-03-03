require './condition_checker'

class ItemCountGreaterThan < ConditionChecker

  def check(item_count)
    item_count > @value
  end

end
