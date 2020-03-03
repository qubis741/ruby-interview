require './offer_action/set_total_percentage_discount'
require './offer_action/set_item_price_for_every_item_of_kind'
require './offer_action/set_item_price_for_every_item_of_modulo'

class OfferActionFactory

  def self.build(name:, value:, target:, to:)
    raise "Offer value has to be number" if !value&.is_a?(Numeric)
    raise "Offer target has to be number" if target && !target.is_a?(Numeric)
    raise "Offer to param has to be nil or 'all' or '% number'" if to && !to == 'all' && !to.match(/^(% \d)$/)

    if name == "total_price_percentage_discount"
      SetTotalPercentageDiscount.new(value, target)
    elsif name == "item_price_change" && to == "all"
      SetItemPriceForEveryItemOfKind.new(value, target)
    elsif name == "item_price_change" && to.include?("%")
      SetItemPriceForEveryItemOfModulo.new(value, target, to)
    else
      raise "Invalid offer"
    end
  end

end
