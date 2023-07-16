# The hooks are per object or per class, you have to add to each one individually, not global
# method_missing is one of the most common hooks that people write in ruby

class CookBook
  attr_accessor :title, :author
  def initialize
    @recipes = []
  end

  def method_missing(m, *args, &block) # override here
    @recipes.send(m, *args, &block) # we will send the command to the array here, and exec it on that
  end
end

class Recipe
  attr_accessor :main_ingredient
  def initialize(main_ingredient)
    @main_ingredient = main_ingredient
  end
end

recipe_for_cake = Recipe.new('cake')
recipe_for_chicken = Recipe.new('chicken')
recipe_for_beef = Recipe.new('beef')


cb = CookBook.new
cb << recipe_for_cake
cb << recipe_for_chicken
cb << recipe_for_beef

beef_dishes = cb.select{|recipe| recipe.main_ingredient == 'beef'}
p beef_dishes # [#<Recipe:0x00007fc61d8b5840 @main_ingredient="beef">] one recipe which is the beef recipe

# Included and prepend event hooks
module M
  def self.included(c)
    p "I have been mixed into class #{c}" # literally all it does is it says it has been included and that is all
  end
end

class C
  include M # all we are doing is including, "I have been mixed into class C" gets printed
end

module SpeakerModule
  def self.included(klass)
    def klass.speak
      p 'I am now able to speak' # class method
    end
  end

  def meow
    p 'meow' # instance method
  end
end

class Cat
  include SpeakerModule
end

cat = Cat.new
Cat.speak # "I am now able to speak", define on the class by the mixin module
cat.meow # "meow" instance method defined on the module

# Intercepting extend

module Extender
  def self.extended(klass)
    p "Module #{self} is being used by class #{klass}"
  end

  def instance_method
    p "This is an instance method supplied by the module"
  end
end

my_obj = Object.new
my_obj.extend(Extender) # "Module Extender is being used by class #<Object:0x00007fc6e508be58>"
my_obj.instance_method # "This is an instance method supplied by the module"

# Extending an object with a module is the same as including that module in the objects singleton class


# Intercepting inheritance

class Parent
  def self.inherited(subclass)
    p "#{self} just got subclassed by #{subclass}"
  end
end

class Child < Parent  #"Parent just got subclassed by Child"
end

# Listing objects non private methods
string = "Testing string"
p string.methods.grep(/case/).sort # [:casecmp, :casecmp?, :downcase, :downcase!, :swapcase, :swapcase!, :upcase, :upcase!]

# Listing private and protected methods

class Person
  attr_reader :name
  def name=(name)
    @name = name
    normalize_name()
  end
  private
  def normalize_name()
    @name.gsub!(/[^-a-z'.\s]/i, '') # remove the chars you dont want
  end
end

david = Person.new
david.name = '123David!!! Bl%a9ck'
p david.name # "David Black"
p david.private_methods.sort.grep(/normal/) # [:normalize_name]

# instance_methods returns the public and protected instance methods
# public_instance_methods return only the public methods
# protected_instance_methods and private_instance_methods return either private or protected methods respectively
# If you pass in false, you will only get the methods actually defined on the on the class or module you are querying

# Introspection of variables and constants
# Listing the local and global variables

x = 1 
p local_variables() # [:recipe_for_cake, :recipe_for_chicken, :recipe_for_beef, :cb, :beef_dishes, :cat, :my_obj, :string, :david, :x]
p global_variables() # [:$-p, :$&, :$`, :$', :$+, :$=, :$KCODE, :$-K, :$-a, :$-l, :$,, :$/, :$-0, :$\, :$:, :$-I, :$LOAD_PATH, :$", :$LOADED_FEATURES, :$@, :$stdin, :$stdout, :$stderr, :$>, :$<, :$., :$FILENAME, :$-i, :$*, :$SAFE, :$VERBOSE, :$-v, :$-w, :$-W, :$DEBUG, :$-d, :$0, :$PROGRAM_NAME, :$_, :$~, :$!, :$;, :$-F, :$?, :$$]

p david.instance_variables # [:@name]

def x
  y()
end

def y
  z()
end

def z
  p 'the stack trace of how you got here is below:'
  p caller() # ["/Users/sheffmachine/Projects/rubyplayground/pureruby/ruby_lifecycle_hooks.rb:138:in `y'", "/Users/sheffmachine/Projects/rubyplayground/pureruby/ruby_lifecycle_hooks.rb:134:in `x'", "/Users/sheffmachine/Projects/rubyplayground/pureruby/ruby_lifecycle_hooks.rb:146:in `<main>'"]
end

x()





