class Storefront
    def greet do
        puts "You walk up to the door of the Magical Gem Shop. You're greeted by the wise(?) old owl above the door. \n"
        puts "🦉 \"Hello! Whooo might you be?\" \n"
        puts "(Enter 1 to reply: I'm an adventurer!) \n"
        puts "(Enter 2 to reply: Don't you recognize me? I'm the shopkeeper!)\n"

        # get user input
        if (answer == 1) do
            puts "🦉 \"Ah, welcome! Come on in!\" \n"
            puts "The door swings open, inviting you into the Magical Gem Shop. \n"
            #create Adventurer
        end
        elsif (answer == 2) do
            puts "🦉 \"I'm sorry, my eyesight is bad. I need you to tell me the password!\" \n"
            puts "(Please enter the password) \n"
            #get user input
            if (password == "the password") do
                puts "🦉 \"That's correct! Welcome!\" \n"
                puts "The door swings open, inviting you into your shop. \n"
                #create Shopkeeper
            end
            else do
                puts "The owl suddenly flies at you! \n"
                puts "Run away! She takes defending the magic treasures very seriously. \n"
            end
        end


    end

    # From now on, we need to check if the user is an Adventurer or Shopkeeper
    # This will affect what they can do and which menu they will be shown. 

end