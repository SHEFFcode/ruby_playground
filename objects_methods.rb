str = 'Hello world'

def str.shout
  "#{self.upcase}!!!"
end

p "sorted methods: #{str.methods.sort}"
p "singleton methods: #{str.singleton_methods.sort}"
p "public instance methods #{String.public_instance_methods}"
p "instance methods just defined in this class and not in ancestry #{String.instance_methods(false)}"