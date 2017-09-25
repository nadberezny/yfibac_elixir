defmodule PricingRules.Manifest do
  @moduledoc """
  Manifest decides which pricing rules will be applied on checkout.
  """

  @active [
    PricingRules.BulkPurchase,
    PricingRules.BuyXGetOneFree
  ]

  def active_rules, do: @active
end
