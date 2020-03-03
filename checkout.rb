require './promotional_rule_factory'
require './promotional_rule'

class Checkout
  attr_accessor :promotional_rules, :total, :items, :total_percentage_discount

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules.map do |pr|
      PromotionalRuleFactory.build(
          id: pr[:id],
          name: pr[:name],
          condition: pr[:condition],
          offer: pr[:offer]
      )
    end
    @items = {}
    @total = 0
    @total_percentage_discount = 1
  end

  def scan(item)
    @items["item_#{@items.size}"] = item.clone
    count_total
    apply_promotional_rules
    @promotional_rules.each { |pr| pr.applied_rule = false }
  end

  def total
    "#{@total} £"
  end

  private

  def apply_promotional_rules
    promotional_rules.each do |pr|
      next if !pr || pr.applied_rule

      if pr.is_a?(TotalPricePercentageDiscount)
        apply_rule(pr) do
          @total_percentage_discount = pr.apply_rule(@total)
        end
      end

      if pr.is_a?(ItemPriceChange)
        item_count = item_count(pr.condition[:target])
        apply_rule(pr) do
          map_items_of_kind(pr.offer[:target]) do |items_of_kind|
            pr.apply_rule(item_count, items_of_kind)
          end
        end
      end

    end
    count_total
  end

  def apply_rule(pr)
    yield
    apply_promotional_rules if pr.applied_rule
  end

  def map_items_of_kind(id)
    items_of_kind = items.select { |_key, item| item.id == id }
    yield(items_of_kind)
  end

  def item_count(id)
    items.select { |_key, item| item.id == id }.count
  end

  def count_total
    temp = 0
    @items.each { |_key, item| temp += item.price }
    @total = (temp * @total_percentage_discount).round(2)
  end

end
