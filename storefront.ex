defmodule Storefront do
  @moduledoc """
  Command-line interface for the Potion Shop.
  """
# This file will show our wares to passing adventurers (read: handle user interaction)
# remember to add our other files!


  # Greet the adventurer & show what potions we have to offer
  def run do
    Inventory.start_link()
    IO.puts("Greetings, adventurer! Care to purchase a potion? ")
    loop()
    # user says no, we pester them lol
    # user says yes / maybe
    # go thru list of potions to show user the options
  end

  defp loop do
    IO.puts("""
    
    Choose an option:
    1. View Inventory
    2. Buy Potion
    3. Restock Potion
    4. Exit
    """)

    choice = IO.gets("Your choice: ") |> String.trim()

    case choice do
      "1" ->
        Inventory.display_inventory()
        loop()

      "2" ->
        potion = IO.gets("Enter potion name: ") |> String.trim()
        qty = IO.gets("Enter quantity to buy: ") |> String.trim() |> String.to_integer()
        Inventory.buy_potion(potion, qty)
        loop()

      "3" ->
        potion = IO.gets("Enter potion name: ") |> String.trim()
        qty = IO.gets("Enter quantity to restock: ") |> String.trim() |> String.to_integer()
        Inventory.add_potion(potion, qty)
        loop()

      "4" ->
        IO.puts("👋 Thanks for visiting the Potion Shop! Goodbye!")

      _ ->
        IO.puts("❓ Invalid option, try again.")
        loop()
    end
  end
end
