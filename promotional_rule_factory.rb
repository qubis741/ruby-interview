require './promotional_rule/total_price_percentage_discount'
require './promotional_rule/item_price_change'

class PromotionalRuleFactory

  def self.build(id:, name:, condition:, offer:)
    raise "ID is required and has to be numeric" if !id || !id.is_a?(Numeric)
    raise "Condition is required and has to be hash" if !condition || !condition.is_a?(Hash)
    raise "Offer is required and has to be hash" if !offer || !offer.is_a?(Hash)

    case name
    when "total_price_percentage_discount"
      TotalPricePercentageDiscount.new(id, name, condition, offer)
    when "item_price_change"
      ItemPriceChange.new(id, name, condition, offer)
    else
      raise "Unknown PR name"
    end
  end

end
