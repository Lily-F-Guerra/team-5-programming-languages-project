class MagicGem
  attr_accessor :name, :price, :description, :quantity

  def initialize(name, price, description, quantity)
    @name = name
    @price = price
    @description = description
    @quantity = quantity
  end

  def display
    puts "💎 #{name} — #{description}"
    puts "   Price: #{price} gold | Stock: #{quantity}\n"
  end

  def update_stock(change)
    @quantity += change
    @quantity = 0 if @quantity < 0
  end

  def decrease_stock(change)
    @quantity -= change
    @quantity = 0 if @quantity < 0
  end
end
