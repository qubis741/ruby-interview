require './promotional_rule'

class TotalPricePercentageDiscount < PromotionalRule

  def apply_rule(total_price)
    @applied_rule = @condition_checker.check(total_price)
    @applied_rule ? @offer_action.trigger : 1
  end

end
