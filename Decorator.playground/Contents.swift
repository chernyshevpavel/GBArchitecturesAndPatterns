protocol Coffee {
    var price: Int {get set}
    func calculatePrice() -> Int
}

protocol CoffeeDecorator: Coffee {
    var coffee: Coffee {get set}
    init(coffee: Coffee)
    func calculatePrice() -> Int
}

extension CoffeeDecorator {
    func calculatePrice() -> Int {
        return coffee.calculatePrice() + price
    }
}


class SimpleCoffee: Coffee {
    var price: Int
    
    init(price: Int) {
        self.price = price
    }
    
    func calculatePrice() -> Int {
        return price
    }
}

class MilkDecorator: CoffeeDecorator {
    var coffee: Coffee
    var price: Int = 15
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
}

class WhipDecorator: CoffeeDecorator {
    var coffee: Coffee
    var price: Int = 10
    
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
}

class SugarDecorator: CoffeeDecorator {
    var coffee: Coffee
    var price: Int = 20
    
    required init(coffee: Coffee) {
        self.coffee = coffee
    }
}

var standartCoffee = SimpleCoffee(price: 80)
var total = WhipDecorator(coffee: MilkDecorator(coffee: standartCoffee)).calculatePrice()
var royalCoffee = SimpleCoffee(price: 100)
total = SugarDecorator(coffee: WhipDecorator(coffee: MilkDecorator(coffee: MilkDecorator(coffee: royalCoffee)))).calculatePrice()

