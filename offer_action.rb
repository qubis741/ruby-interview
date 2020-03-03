class OfferAction
  attr_accessor :value, :target, :to

  def initialize(value, target, to = nil)
    @value = value
    @target = target
    @to = to
  end

end
