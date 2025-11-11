# We need to keep track of the potion shop's inventory.

def elixir_inventory do
	# Create list of our potions
	# Use tuple (map potions to their quantities) or list?
	  potions = [
	{"Healing Potion", 10},
	{"Mana Potion", 5},
	{"Strength Potion", 3},
	{"Invisibility Potion", 2}
  ]

  # Function to display current inventory
  def display_inventory(potions) do
	IO.puts("Current Potion Inventory:")
	Enum.each(potions, fn {potion, quantity} ->
	  IO.puts("#{potion}: #{quantity}")
	end)
  end

  # Function to add potions to inventory
  def add_potion(potions, potion_name, quantity) do
	case Enum.find_index(potions, fn {name, _} -> name == potion_name end) do
	  nil -> 
		[{potion_name, quantity} | potions]
	  index -> 
		List.update_at(potions, index, fn {name, qty} -> {name, qty + quantity} end)
	end
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
			IO.puts("Not enough #{name} in inventory.")
			{name, qty}
		  end
		end)
	end
  end

  # Example usage
  potions = elixir_inventory()
  display_inventory(potions)
  potions = add_potion(potions, "Healing Potion", 5)
  display_inventory(potions)
  potions = remove_potion(potions, "Mana Potion", 2)
  display_inventory(potions)

end
