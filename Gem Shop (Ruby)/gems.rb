class Gem
    #attributes: price, description, quantity

    def display do
        puts "This is a magic gem."
    end

    def update_stock() do
        #pass the number we want to add/remove (positive for add, negative for remove)
        quantity -= change
    end
