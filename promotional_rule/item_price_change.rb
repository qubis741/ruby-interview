require './promotional_rule'

class ItemPriceChange < PromotionalRule

  def apply_rule(item_count, items)
    @applied_rule = @condition_checker.check(item_count)
    if @applied_rule
      @offer_action.trigger(items)
    end
  end

  private

  def valid_structure?
    @condition[:attribute] && @condition[:target] && @condition[:action] && @condition[:value] &&
        @offer[:target] &&  @offer[:value] && @offer[:to]
  end

end
