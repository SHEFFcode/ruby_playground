require 'thread'

THREADS_COUNT = 25

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

donor_account = Account.new(1000000)
receiver_account = Account.new(0)

# ============= WITH A RACE CONDITION ============== #
# threads = (0...THREADS_COUNT).map {
#   Thread.new {
#     while donor_account.amount > 0 # the issue is that we are reading amount outside of syncronization
#       donor_account.debit(1)
#       receiver_account.credit(1)
#     end
#   }
# }
# ============= END WITH A RACE CONDITION ============== #
mutex = Mutex.new
threads = (0...THREADS_COUNT).map {
  Thread.new {
    while donor_account.amount > 0 # We do not want to sycn here, cause then no work will be able to be done by any of the threads, we become single threaded
      mutex.synchronize {
        if donor_account.amount > 0 # Here we do another check in a mutex inside the loop
          donor_account.debit(1)
          receiver_account.credit(1)
        end
      }
    end
  }
}

threads.each {|t| t.join}

p "Amount in donor account is #{donor_account.amount}" # "Amount in donor account is 0", but sometimes "Amount in donor account is -12"
p "Amount in receiver account is #{receiver_account.amount}" # "Amount in receiver account is 1000000", but sometimes "Amount in receiver account is 1000012"

