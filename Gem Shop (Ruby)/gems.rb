class Gem
    #attributes: price, quantity, description
    def initialize(p, q, d) do
        price = p
        quantity = q
        description = d 
    end

    def display do
        puts description
    end

    def update_stock(change) do
        #pass the number we want to add/remove (positive for add, negative for remove)
        quantity -= change
    end


    
