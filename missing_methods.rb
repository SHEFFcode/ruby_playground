class Person
  PEOPLE = []
  attr_reader :name, :hobbies, :friends

  def initialize(name)
    @name = name
    @hobbies = []
    @friends = []
    PEOPLE << self
  end

  def learn_hobby(hobby)
    @hobbies << hobby
  end

  def make_friend(friend)
    @friends << friend
  end

  # here we will make a method for all people
  def self.method_missing(m, *args)
    method = m.to_s
    if method.start_with?('all_with_')
      particular_method = method[9..-1]
      if self.public_method_defined?(particular_method)
        PEOPLE.find_all do |person|
          person.send(particular_method).include?(args[0]) # find all people with a particular hobby or firned
        end
      else
        raise ArgumentError, "Can't find #{particular_method}"
      end
    end
  end

end

josh = Person.new('Josh')
oleg = Person.new('Oleg')

p josh.make_friend('oleg')

p Person

p Person.all_with_friends('oleg')
p Person::PEOPLE

