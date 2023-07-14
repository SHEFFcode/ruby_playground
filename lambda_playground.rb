# Lambdas are special kinds of procs
lam = lambda {p 'I am a lambda!'}
lam.call # "I am a lambda!"

# Lambdas also have a different dynamic with their return statements
# In a lambda return will take you out of the lambda execution, in the proc it will take you out of the wrapping function

def return_test
  l = lambda {return}
  l.call
  p 'I am still here happily running in the outer function'
  pr = Proc.new {return}
  pr.call
  p 'I am never called :(' # this will never be called
end

return_test() # "I am still here happily running in the outer function"

# The return method in a proc when ran inside the main object will terminate the program, so its pretty dangerous

# Lambdas don't like being called with the wrong number of params, they are fussy
lam = lambda {|x| p x}
lam.call(1) # 1
# lam.call # wrong number of arguments (given 0, expected 1) (ArgumentError)
# lam.call(1, 2, 3) # wrong number of arguments (given 3, expected 1) (ArgumentError)

# There is also a lambda literal constructor, which is called the "stabby lambda"

lam = -> {puts 'hi I am a stabby lambda!'}
lam.call # hi I am a stabby lambda!

# if you want params you do like this
mult = ->(x, y) {p (x * y)}
mult.call(2, 2) # 4

mult = ->(x, y = 2) {p (x * y)}
mult.call(2) # 4, you can use the default arguments here

