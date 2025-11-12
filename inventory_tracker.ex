defmodule Inventory do
  @moduledoc """
  Manages the potion shop's inventory using an Agent.
  """
# We need to keep track of the potion shop's inventory.
  def start_link do
	# Create list of our potions
	# Use tuple (map potions to their quantities) or list?
	  potions = %{
		"Healing Potion" => 10,
		"Mana Potion" => 5,
		"Strength Potion" => 3,
		"Invisibility Potion" => 2,
		"Stamina Elixir" => 7,
		"Mystery Vial" => 11,
		"Elixir Programming Language" => 1
	  }

	Agent.start_link(fn -> potions end, name: __MODULE__)
  end

  def prices do
    %{
      "Healing Potion" => 5,
      "Mana Potion" => 8,
      "Strength Potion" => 12,
      "Invisibility Potion" => 20,
      "Stamina Elixir" => 10,
      "Mystery Vial" => 15,
      "Elixir Programming Language" => 100
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


  # Example usage
  # potions = elixir_inventory()
  # display_inventory(potions)
  # potions = add_potion(potions, "Healing Potion", 5)
  # display_inventory(potions)
  # potions = remove_potion(potions, "Mana Potion", 2)
  # display_inventory(potions)

end
