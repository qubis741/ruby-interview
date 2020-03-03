require './condition_checker/total_price_greater_than'
require './condition_checker/item_count_greater_than'

class ConditionCheckerFactory

  def self.build(value:, target:, attribute:, action:)
    raise "Condition value has to be number" if !value&.is_a?(Numeric)
    raise "Condition target has to be number" if target && !target.is_a?(Numeric)

    if attribute == "total_price" && action == ">"
      TotalPriceGreaterThan.new(value, target)
    elsif attribute == "item_count" && action == ">"
      ItemCountGreaterThan.new(value, target)
    else
      raise "Invalid condition"
    end
  end

end
