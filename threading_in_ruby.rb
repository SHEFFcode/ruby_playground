require 'thread'

class Account
  attr_reader :amount
  def initialize(initial_amount)
    @amount = initial_amount
    @mutex = Mutex.new
  end
  def debit(amount)
    @mutex.synchronize  { # add some thread safety
      @amount -= amount
    }
  end
  def credit(amount)
    @mutex.synchronize { # add some thread safety
      @amount += amount
    }
  end
end

THREADS_COUNT = 10
ITERATE = 100000 # 10 * 100000 million dollars
account = Account.new(0)
# let's addd a mutex
mutex = Mutex.new

threads = (0...THREADS_COUNT).map {
  Thread.new {
    ITERATE.times {
        account.credit(1)
    }
  }
}

threads.each {|t| t.join}

p 'Account should be at 1,000,000'
p "Account has #{account.amount}" # "Account has 11000000"
p "I am missing #{1000000 - account.amount.to_i}" # -10000000