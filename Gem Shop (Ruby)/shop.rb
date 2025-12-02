class Storefront
    #include whatever classes we need to include
    
    def greet do
        puts "You walk up to the door of the Magical Gem-porium. You're greeted by the wise(?) old owl above the door. \n"
        puts "🦉 \"Hello! Whooo might you be?\" \n"
        puts "(Enter 1 to reply: I'm an adventurer!) \n"
        puts "(Enter 2 to reply: Don't you recognize me? I'm the shopkeeper!)\n"

        # get user input
        answer = gets.chomp

        if (answer == 1) do
            puts "🦉 \"Ah, welcome! Come on in!\" \n"
            puts "The door swings open, inviting you into the Magical Gem-porium. \n"
            #create Adventurer
            adventurer = Adventurer.new
            #run the Adventurer version of the menu
            menu(adventurer);
        end
        elsif (answer == 2) do
            puts "🦉 \"I'm sorry, my eyesight is bad. I need you to tell me the password before I'll let you in.\" \n"
            puts "(Please enter the password) \n"
            #get user input
            password = gets.chomp
            if (password == "the password") do
                puts "🦉 \"That's correct! Welcome!\" \n"
                puts "The door swings open, inviting you into your shop. \n"
                #create Shopkeeper
                shopkeeper = Shopkeeper.new
                #run the Shopkeeper version of the menu
                menu(shopkeeper);
            end
            else do
                puts "The owl suddenly flies at you! \n"
                puts "Run away! She takes defending the magic treasures very seriously. \n"
                #end the program
            end
        end


    end

    def shelves do
        # This method will create the list of gems for sale, prices, and number in stock.
        # Create a list of Gem objects initialized with price, quantity, and a brief description. 
        # We should be able to access this as a user.
        # Maybe pass to users when they're created?

    end

    def menu(user) do
        #check type of the user
        #if user is Adventurer, show one menu
        #if user is Shopkeeper, show a different menu
    end

    
    # From now on, we need to check if the user is an Adventurer or Shopkeeper
    # This will affect what they can do and which menu they will be shown. 
    # Maybe we pass the Adventurer/Shopkeeper into these functions?

end