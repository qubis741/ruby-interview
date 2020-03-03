require './offer_action'

class SetItemPriceForEveryItemOfModulo < OfferAction

  def trigger(items)
    modulo_by = @to.split(' ')[1].to_i
    count = 1
    items.each do |_key, item|
      if count % modulo_by == 0
        item.price = @value
      end
      count += 1
    end
  end

end
