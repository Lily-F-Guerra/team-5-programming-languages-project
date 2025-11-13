defmodule PlayerInventory do
  @moduledoc """
  Tracks the player's personal inventory using an Agent.
  """
 #launches agent process and creates empty map
  def start_link do
    items = %{} # empty at start

    case Agent.start_link(fn -> items end, name: __MODULE__) do
      {:ok, _pid} -> :ok
      {:error, {:already_started, _pid}} -> :ok
    end
  end

  #gets state of player inventory and displays
  def display_inventory do
    inventory = Agent.get(__MODULE__, & &1)
    IO.puts("\n🎒 Your Inventory:")

    if map_size(inventory) == 0 do
      IO.puts(" - (empty)")
    else
      Enum.each(inventory, fn {potion, quantity} ->
        IO.puts(" - #{potion}: #{quantity}")
      end)
    end
  end

  #makes newer version of inventory with potion count updated
  def add_potion(potion, qty) do
    Agent.update(__MODULE__, fn inv ->
      Map.update(inv, potion, qty, &(&1 + qty))
    end)
    IO.puts("🧪 Added #{qty} #{potion}(s) to your inventory.")
  end

  def remove_potion(potion, qty) do
    Agent.get_and_update(__MODULE__, fn inv ->
      case Map.get(inv, potion, 0) do
        current when current >= qty ->
          new_inv =
            if current - qty > 0 do
              Map.put(inv, potion, current - qty)
            else
              Map.delete(inv, potion)
            end

          {{:ok, :removed}, new_inv}

        _ ->
          IO.puts("⚠️ You don’t have enough #{potion}(s) to sell.")
          {{:error, :not_enough}, inv}
      end
    end)
  end
end
