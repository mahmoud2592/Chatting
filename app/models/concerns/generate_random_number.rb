require "active_support/concern"

module GenerateRandomNumber
  extend ActiveSupport::Concern
  
  def generate_random_number(number_of_digits=6)
    rand(10**(number_of_digits-1)..10**number_of_digits)
  end
end