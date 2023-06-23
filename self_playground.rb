# p self

x = 5

def add_one(x)
  x + 1
end

res = add_one(x)

# p res
# p x


# p $0
# p $$


class Hello

  def initialize
    @@ITEMS = []
  end

  def get_items
    @@ITEMS
  end

end

bye = Hello.new

hi = Hello.new
hi.get_items() << 1


p hi.get_items()
p bye.get_items()