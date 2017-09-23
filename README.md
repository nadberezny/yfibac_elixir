[![CircleCI](https://circleci.com/gh/nadberezny/yfibac_elixir.svg?style=svg)](https://circleci.com/gh/nadberezny/yfibac_elixir)

To run **tests** type:  
`mix test`

To run **console** type:  
`iex -S mix`

The app is the **Elixir** implementation of Cabify's Ruby coding exercise:
https://gist.github.com/patriciagao/377dca8920ba3b1fc8da

[Here](https://github.com/nadberezny/yfibac) you can find **Ruby** implementation of the same exercise.

Those examples:
```
Items: VOUCHER, TSHIRT, MUG
Total: 32.50€

Items: VOUCHER, TSHIRT, VOUCHER
Total: 25.00€

Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
Total: 81.00€

Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
Total: 74.50€
```
are included in `test/integration/checkout_test.exs`


### Code guidelines
#### Checkout interface
`Checkout` module is the interface for `#scan` actions.
```elixir
co = %Checkout{}
co = Checkout.scan(co, "VOUCHER")
price = co.total
```  

#### Scan operation
Scan pipelines checkout operations. Through all scan operation one data type is passed, which is `Checkout.t` 

#### Pricing rules
Pricing rules are defined in `PricingRules.Manifes`. They can also be passed explicitly:
```elixir
co = %Checkout{pricing_rules: [MyPricingRule]}
Checkout.scan(co, "FOO")
```

#### Defining new pricing rules
To add a new rule simply:
1. Define a module that includes with `use` declaration `PricingRules`. A module must implement `code/0`, `eligible/2` and `apply_rule/2`.
2. Include new rule in `PricingRules::Manifest`.

#### Bulk purchase
This rule depends on _code_, _discount_ and _quantity_ preferences. For all checkout items within code scope, if their quantity
is equal or greater than quantity preference, then for each item preferred discount is applied.
For different type of items specific required volume and discount can be applied.

#### Buy X get one free
This rule depends on _code_ and _quantity_ preferences. Quantity preference defines for how many items of the same type buyer gets the
same item for free.
For different types of items, specific quantity can be required to fulfill promotion. E.g. you can set that for 3 mugs you get one free,
and for 4 t-shirts you get one for free.

#### Persistance layer
In the real life app this would probably be some SQL RDBMS. 
Here we have simple JSON file (`db/cabify_db.json`). Mappings to item structs are handled by repository modules.

____