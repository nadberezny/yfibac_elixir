defmodule PricingRuleRepoTest do
  use ExUnit.Case
  doctest PricingRuleRepo

  test "#find_by_code to return :ok struct with item when product exists" do
    item = %PricingRules.Item{code: "bulk-purchase", items: [%{"code" => "TSHIRT", "discount" => 1.0, "quantity" => 3}]}
    assert {:ok, item} == PricingRuleRepo.find_by_code("bulk-purchase")
  end

  test "#find to return :error struct with nil when product is non-existing" do
    assert {:error, nil} == PricingRuleRepo.find_by_code("esahcrup-klub")
  end
end
