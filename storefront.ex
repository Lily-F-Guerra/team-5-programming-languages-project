defmodule Storefront do
  @moduledoc """
  Command-line interface for the Potion Shop.
  """
# This file will show our wares to passing adventurers (read: handle user interaction)
# remember to add our other files!


  # Greet the adventurer & show what potions we have to offer
  def run do
    Inventory.start_link()
    PlayerInventory.start_link()
    IO.puts("Greetings, adventurer! Care to purchase a potion? ")
    intro_loop(300)#300 starting gold
  end

  defp intro_loop(gold) do
    IO.puts("""

     1. Yes
     2. No
    """)

    choice = IO.gets(" Whattaya say?: ") |> String.trim()
    case choice do
      "1" -> loop(gold)

      "2" ->
        IO.puts("I wont let you leave")
        intro_loop(gold)

      _ ->
      IO.puts("❓ Huh? Speak up")
      intro_loop(gold)
    end

  end
  defp loop(gold) do
    IO.puts("""
    💰 Your Gold: #{gold}
    Choose an option:
    1. View Shop Inventory
    2. View Your Inventory
    3. Buy Potion
    4. Sell Potion
    5. Exit
    """)

    choice = IO.gets("Your choice: ") |> String.trim()

    case choice do
      "1" ->
        Inventory.display_inventory()
        loop(gold)

      "2" ->
        PlayerInventory.display_inventory()
        loop(gold)

      "3" ->
        potion = IO.gets("Enter potion name: ") |> String.trim()
        qty = IO.gets("Enter quantity to buy: ") |> String.trim() |> String.to_integer()
        case Inventory.buy_potion(potion, qty, gold) do
          {:ok, new_gold} ->
            PlayerInventory.add_potion(potion, qty)
            loop(new_gold)

          {:error, same_gold} -> loop(same_gold)
        end

       "4" ->
          potion = IO.gets("Enter potion name: ") |> String.trim()
          qty = IO.gets("Enter quantity to sell: ") |> String.trim() |> String.to_integer()

          case PlayerInventory.remove_potion(potion, qty) do
            {:ok, :removed} ->
              case Inventory.sell_potion(potion, qty, gold) do
                {:ok, new_gold} -> loop(new_gold)
                {:error, same_gold} -> loop(same_gold)
              end

            {:error, :not_enough} ->
              # PlayerInventory printed the warning already
              loop(gold)
          end


      #"3" ->
      #  potion = IO.gets("Enter potion name: ") |> String.trim()
      #  qty = IO.gets("Enter quantity to restock: ") |> String.trim() |> String.to_integer()
      #  Inventory.add_potion(potion, qty)
      #  loop(gold)

      "5" ->
        IO.puts("👋 Thanks for visiting the Potion Shop! Goodbye!")

      _ ->
        IO.puts("❓ Invalid option, try again.")
        loop(gold)
    end
  end
end
