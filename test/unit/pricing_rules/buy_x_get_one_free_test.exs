defmodule PricingRules.BuyXGetOneFreeTest do
  use ExUnit.Case
  doctest PricingRules.BuyXGetOneFree

  import TestHelpers
  alias PricingRules.BuyXGetOneFree, as: BuyXGetOneFree

  test "apply" do
    item = %Checkout.Item{code: "VOUCHER", price: 5}

    checkout = %Checkout{items: [item]}
    checkout = BuyXGetOneFree.apply(checkout)
    assert discount_total(checkout.items) == 0

    checkout = %Checkout{items: [item, item]}
    checkout = BuyXGetOneFree.apply(checkout)
    assert discount_total(checkout.items) == 5

    checkout = %Checkout{items: [item, item, item]}
    checkout = BuyXGetOneFree.apply(checkout)
    assert discount_total(checkout.items) == 5
  end
end
