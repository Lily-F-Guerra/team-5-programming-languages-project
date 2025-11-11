# This file will show our wares to passing adventurers (read: handle user interaction)
# remember to add our other files!

defmodule Storefront do
  # Greet the adventurer & show what potions we have to offer
  def greet do
    IO.puts("Greetings, adventurer! Care to purchase a potion?")
    # user says no, we pester them lol
    # user says yes / maybe
    # go thru list of potions to show user the options
  end

  # Adventurer selects a potion, add it to their order
  def choose do
    # print a message to prompt user input
    # interpret input to find potion type & quantity
    # add to order
    # update total cost
    # this may need to give the option to l00p & choose more potions
    # 0nce user decides to stop, go to trade module
  end

  # Complete transaction, receive coin for the potions
  def trade do
    # show adventurer the total price
    # prompt them to enter the price to receive the potions
    IO.puts("An excellent trade! Come back again!")
  end


end

