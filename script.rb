require './checkout.rb'
require './item'

# 001	Red Scarf	£9.25
# 002	Silver cufflinks	£45.00
# 003	Silk Dress	£19.95
item_1 = {
    id: 001,
    name: "Red Scarf",
    price: 9.25
}
item_2 = {
    id: 002,
    name: "Silver cufflinks",
    price: 45.00
}
item_3 = {
    id: 003,
    name: "Silk Dress",
    price: 19.95
}

examples = [
    [item_1, item_2, item_3],
    [item_1, item_3, item_1],
    [item_1, item_2, item_1, item_3],
    [item_1, item_2, item_1, item_3, item_1]
]


promotions = [
    {
        id: 1,
        name: "total_price_percentage_discount",
        condition: {
            attribute: "total_price",
            action: ">",
            value: 60,
        },
        offer: {
            value: 0.9
        }
    },
    {
        id: 2,
        name: "item_price_change",
        condition: {
            attribute: "item_count",
            target: 001,
            action: ">",
            value: 1,
        },
        offer: {
            target: 001,
            value: 8.5,
            to: "all"
        }
    },
    {
        id: 3,
        name: "item_price_change",
        condition: {
            attribute: "item_count",
            target: 001,
            action: ">",
            value: 2,
        },
        offer: {
            target: 001,
            value: 0,
            to: "% 3"
        }
    }
]

cart = examples[ARGV[0].to_i]
p cart
begin
  co = Checkout.new(promotions)
  cart.each do |item|
    item_obj = Item.new(**item)
    co.scan(item_obj)
  end
  price = co.total
  p price
rescue RuntimeError => e
  p e
end

# Basket: 001, 002, 003
# Total price expected: £66.78
#
# Basket: 001, 003, 001
# Total price expected: £36.95
#
# Basket: 001, 002, 001, 003
# Total price expected: £73.76
#
# Basket: 001, 002, 001, 003, 001
# Total price expected: £73.76
