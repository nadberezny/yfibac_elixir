defmodule PricingRules.BulkPurchaseTest do
  use ExUnit.Case
  doctest PricingRules.BulkPurchase

  import TestHelpers
  alias PricingRules.BulkPurchase, as: BulkPurchase

  test "apply" do
      item = %Checkout.Item{code: "TSHIRT", price: 20}

      checkout = %Checkout{items: [item]}
      checkout = BulkPurchase.apply(checkout)
      assert discount_total(checkout.items) == 0

      checkout = %Checkout{items: [item, item]}
      checkout = BulkPurchase.apply(checkout)
      assert discount_total(checkout.items) == 0

      checkout = %Checkout{items: [item, item, item]}
      checkout = BulkPurchase.apply(checkout)
      assert discount_total(checkout.items) == 3
  end
end
