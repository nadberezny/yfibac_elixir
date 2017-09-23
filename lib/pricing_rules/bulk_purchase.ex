defmodule PricingRules.BulkPurchase do
  @moduledoc """
  Buying x or more of a product, the price of that product is reduced,
  where x is the quantity defined in the rule repo.
  """

  use PricingRules

  @code "bulk-purchase"

  def code, do: @code

  defp eligible?(rule, items), do: length(items) >= rule["quantity"]

  defp apply_rule(rule, items) do
    for item <- items, do: %{item | discount: rule["discount"]}
  end
end
