require './offer_action'

class SetItemPriceForEveryItemOfKind < OfferAction

  def trigger(items)
    items.each do |_key, item|
      item.price = @value
    end
  end

end
