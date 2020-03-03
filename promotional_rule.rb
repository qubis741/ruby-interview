require './condition_checker_factory'
require './offer_action_factory'

class PromotionalRule
  attr_accessor :id, :condition, :offer, :applied_rule, :condition_checker, :offer_action

  def initialize(id, name, condition, offer)
    @id = id
    @name = name
    @condition = condition
    @offer = offer

    validate_promotional_rule

    @condition_checker = ConditionCheckerFactory.build(
        value: @condition[:value],
        target: @condition[:target],
        attribute: @condition[:attribute],
        action: @condition[:action]
    )
    @offer_action = OfferActionFactory.build(
        name: name,
        value: @offer[:value],
        target: @offer[:target],
        to: @offer[:to]
    )
  end

  def validate_promotional_rule
    if !valid_structure?
      raise "Invalid structure"
    end
  end

  def valid_structure?
    @condition[:attribute] && @condition[:action] && @condition[:value] && @offer[:value]
  end

end
