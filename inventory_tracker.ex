defmodule Inventory do
  @moduledoc """
  Manages the potion shop's inventory using an Agent.
  """
# We need to keep track of the potion shop's inventory.
  def start_link do
	# Create list of our potions
	  potions = %{
		"HEALING POTION" => 10,
		"MANA POTION" => 5,
		"STRENGTH POTION" => 3,
		"INVISIBILITY POTION" => 2,
		"STAMINA ELIXIR" => 7,
		"MYSTERY VIAL" => 11,
		"ELIXIR PROGRAMMING LANGUAGE" => 1,
    "RED BULL" => 7
	  }

	Agent.start_link(fn -> potions end, name: __MODULE__)
  end

  def prices do
    %{
      "HEALING POTION" => 5,
      "MANA POTION" => 8,
      "STRENGTH POTION" => 12,
      "INVISIBILITY POTION" => 20,
      "STAMINA ELIXIR" => 10,
      "MYSTERY VIAL" => 15,
      "ELIXIR PROGRAMMING LANGUAGE" => 100,
      "RED BULL" => 6
    }
  end

  # Function to display current inventory
  def display_inventory do
	inventory = Agent.get(__MODULE__, & &1)
	IO.puts("\n🧪Current Potion Inventory:")
	Enum.each(inventory, fn {potion, quantity} ->
	  price = Map.get(prices(), potion, "?")
	  IO.puts(" - #{potion}: #{quantity} available (💰 #{price} gold each)")
	end)
  end

  # Function to add potions to inventory
  def add_potion(potion_name, quantity) do
	Agent.update(__MODULE__, fn inv ->
		Map.update(inv, potion_name, quantity, &(&1 + quantity))
		end)
	IO.puts("✅ Added #{quantity} #{potion_name}(s) to inventory.")
  end

  def buy_potion(potion_name, quantity, gold) do
    String.upcase(potion_name)
    Agent.get_and_update(__MODULE__, fn inv ->
      case Map.fetch(inv, potion_name) do
        :error ->
          IO.puts("⚠️ Potion not found.")
          {{:error, gold}, inv}

        {:ok, current_qty} when current_qty >= quantity ->
		  price = Map.get(prices(), potion_name, 0)
          total_cost = price * quantity

		  if gold >= total_cost do
			new_inv = Map.put(inv, potion_name, current_qty - quantity)
			new_gold = gold - total_cost
			IO.puts("💰 You bought #{quantity} #{potion_name}(s) for #{total_cost} gold!")
			{{:ok, new_gold}, new_inv}
		  else
			IO.puts("❌ Not enough gold! You need #{total_cost - gold} more.")
            {{:error, gold}, inv}
		  end



        {:ok, _} ->
          IO.puts("❌ Not enough stock for #{potion_name}.")
          {{:error,gold}, inv}
      end
    end)
  end
 def sell_potion(potion_name, quantity, gold) do
  Agent.get_and_update(__MODULE__, fn inv ->
    case Map.fetch(inv, potion_name) do
      :error ->
        IO.puts("⚠️ Potion not found in shop inventory.")
        {{:error, gold}, inv}

      {:ok, current_qty} ->
        # Look up the price from the prices map
        price_map = prices()
        price = Map.get(price_map, potion_name, 0)
        sell_price = div(price, 2)  # Half value when selling back
        earned = sell_price * quantity

        # Add sold items back to shop inventory
        new_inv = Map.put(inv, potion_name, current_qty + quantity)

        IO.puts("💸 You sold #{quantity} #{potion_name}(s) for #{earned} gold!")
        {{:ok, gold + earned}, new_inv}
    end
  end)
end


  # Example usage
  # potions = elixir_inventory()
  # display_inventory(potions)
  # potions = add_potion(potions, "Healing Potion", 5)
  # display_inventory(potions)
  # potions = remove_potion(potions, "Mana Potion", 2)
  # display_inventory(potions)

end
