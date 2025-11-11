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

  # Function to display current inventory
  def display_inventory do
	inventory = Agent.get(__MODULE__, & &1)
	IO.puts("\n🧪Current Potion Inventory:")
	Enum.each(inventory, fn {potion, quantity} ->
	  IO.puts("#{potion}: #{quantity}")
	end)
  end

  # Function to add potions to inventory
  def add_potion(potion_name, quantity) do
	Agent.update(__MODULE__, fn inv ->
		Map.update(inv, potion_name, quantity, &(&1 + quantity))
		end)
	IO.puts("✅ Added #{quantity} #{potion_name}(s) to inventory.")
  end

  def buy_potion(potion_name, quantity) do
    Agent.get_and_update(__MODULE__, fn inv ->
      case Map.fetch(inv, potion_name) do
        :error ->
          IO.puts("⚠️ Potion not found.")
          {inv, inv}

        {:ok, current_qty} when current_qty >= quantity ->
          IO.puts("💰 You bought #{quantity} #{potion_name}(s)!")
          {inv, Map.put(inv, potion_name, current_qty - quantity)}

        {:ok, _} ->
          IO.puts("❌ Not enough stock for #{potion_name}.")
          {inv, inv}
      end
    end)
  end

		# Function to remove potions from inventory
		def remove_potion(potions, potion_name, quantity) do
			case Enum.find_index(potions, fn {name, _} -> name == potion_name end) do
			nil -> 
				IO.puts("Potion not found in inventory.")
				potions
			index -> 
				List.update_at(potions, index, fn {name, qty} -> 
				if qty >= quantity do
					{name, qty - quantity}
				else
					IO.puts("#{name} is out of stock.")
					{name, qty}
				end
				end)
			end
		end

  # Example usage
  # potions = elixir_inventory()
  # display_inventory(potions)
  # potions = add_potion(potions, "Healing Potion", 5)
  # display_inventory(potions)
  # potions = remove_potion(potions, "Mana Potion", 2)
  # display_inventory(potions)

end
