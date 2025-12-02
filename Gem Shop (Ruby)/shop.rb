require_relative "gems"
require_relative "users"

class Storefront

  def greet
    puts "You walk up to the door of the Magical Gem-porium."
    puts "You're greeted by the wise(?) old owl above the door.\n"
    puts "🦉 \"Hello! Whooo might you be?\"\n"
    puts "(Enter 1 to reply: I'm an adventurer!)"
    puts "(Enter 2 to reply: Don't you recognize me? I'm the shopkeeper!)"

    answer = gets.chomp

    case answer

    when "1"
      puts "🦉 \"Ah, welcome! Come on in!\""
      puts "The door swings open, inviting you into the Magical Gem-porium.\n"

      player = Adventurer.new
      adventurer_menu(player)

    when "2"
      puts "🦉 \"I'm sorry, my eyesight is bad. I need you to tell me the password.\""
      print "Enter password: "
      password = gets.chomp

      if password == "the password"
        puts "🦉 \"That's correct! Welcome!\""
        puts "The door swings open, inviting you into your shop.\n"

        player = Shopkeeper.new
        shopkeeper_menu(player)

      else
        puts "The owl suddenly flies at you!"
        puts "Run away! She takes defending the magic treasures very seriously."
        exit
      end

    else
      puts "The owl tilts her head in confusion. Try again.\n"
      greet
    end
  end

  def shelves
    @gems ||= [
      MagicGem.new("Ruby", 50, "A fiery red gemstone", 5),
      MagicGem.new("Sapphire", 40, "A cool blue gem of clarity", 3),
      MagicGem.new("Emerald", 60, "A vibrant green stone of luck", 2),
      MagicGem.new("Moonstone", 80, "A radiant stone with the power of the moon", 2),
      MagicGem.new("Amulet", 90, "This powerful amulet banishes all darkness", 1),
      MagicGem.new("Ring Pop", 5, "Doesn't do anything, but it's sparkly and sweet!", 12),
      MagicGem.new("Jade", 60, "A charm for protection, carved with artisty", 5)
    ]
  end

  # Adventurer menu
  def adventurer_menu(player)
    loop do
      puts "\n✨ Adventurer Menu ✨"
      puts "1. View gems for sale"
      puts "2. Buy gems"
      puts "3. View your gold"
      puts "4. View your inventory"
      puts "5. Leave shop"

      choice = gets.chomp

      case choice
      when "1"
        shelves.each { |gem| gem.display }
      when "2"
        buy_gem(player)
      when "3"
        puts "You have #{player.gold} gold."
      when "4"
        view_inventory(player)  
      when "5"
        puts "Farewell, traveler!"
        exit
      else
        puts "Invalid option."
      end
    end
  end

  # Shopkeeper menu
  # ---------------------------
  def shopkeeper_menu(player)
    loop do
      puts "\n🛠 Shopkeeper Menu 🛠"
      puts "1. View gems"
      puts "2. Restock gems"
      puts "3. View your gold"
      puts "4. Close shop"

      choice = gets.chomp

      case choice
      when "1"
        shelves.each { |gem| gem.display }
      when "2"
        restock_flow
      when "3"
        puts "Shop gold: #{player.gold}"
      when "4"
        puts "Shop closed."
        greet
      else
        puts "Invalid option."
      end
    end
  end

  def buy_gem(player)
    puts "\nWhich gem would you like to buy?"
    shelves.each_with_index { |gem, i| puts "#{i+1}. #{gem.name} (#{gem.price} gold, stock: #{gem.quantity})" }

    index = gets.chomp.to_i - 1
    gem = shelves[index]

    if gem.nil?
      puts "Invalid choice."
      return
    end

    if gem.quantity <= 0
      puts "Sorry, #{gem.name} is sold out!"
      return
    end

    if player.gold < gem.price
      puts "You don't have enough gold to buy a #{gem.name}!"
      return
    end

    # purchase!
    player.gold -= gem.price
    gem.update_stock(-1)
    player.inventory << gem.name

    puts "✨ You bought a #{gem.name}! ✨"
    puts "Remaining gold: #{player.gold}"
  end

  def view_inventory(player)
    puts "\n🎒 Your Inventory 🎒"

    if player.inventory.empty?
      puts "You don't have any gems yet."
    else
      player.inventory.each_with_index do |item, i|
        puts "#{i+1}. #{item}"
      end
    end
  end

  def restock_flow
    puts "Which gem would you like to restock?"
    shelves.each_with_index { |gem, i| puts "#{i+1}. #{gem.name}" }

    index = gets.chomp.to_i - 1
    if gem = shelves[index]
      print "How many to add? "
      amount = gets.chomp.to_i
      gem.update_stock(amount)
      puts "#{gem.name} stock updated!"
    else
      puts "Invalid choice."
    end
  end

end

# Start the program
Storefront.new.greet
