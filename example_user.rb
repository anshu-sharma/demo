class User
  attr_accessor :name, :email
#the principal importance of instance variables is that they are automatically available in the views, but in general they are used for variables that need to be available throughout a Ruby class.
  def initialize(attributes = {})#it’s the method called when we execute User.new
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
 user = User.new(name: "Michael Hartl", email: "mhartl@example.com")
 user.formatted_email
######
## rm example_user.rb