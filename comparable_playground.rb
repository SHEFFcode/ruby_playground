class Bid
  include Comparable
  attr_accessor :estimate
  def <=>(other_bid)
    if self.estimate < other_bid.estimate
      -1
    elsif self.estimate > other_bid.estimate
      1
    else
      0
    end
  end
end

bid1 = Bid.new
bid1.estimate = 100

bid2 = Bid.new
bid2.estimate = 200

bid3 = Bid.new
bid3.estimate = 200

p bid1 > bid2
p bid2 > bid1
p bid2 == bid3


