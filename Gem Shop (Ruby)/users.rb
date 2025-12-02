class User
  attr_accessor :gold

  def initialize
    @gold = 100
  end
end

class Adventurer < User
  def initialize
    super
  end
end

class Shopkeeper < User
  def initialize
    super
    @gold = 500 # shop starts with more gold
  end
end
