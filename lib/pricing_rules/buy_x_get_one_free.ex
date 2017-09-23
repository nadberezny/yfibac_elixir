defmodule PricingRules.BuyXGetOneFree do
  @moduledoc """
  Fully discounts one of items for each x items,
  where x is the quantity defined in the rule repo.
  """

  use PricingRules

  import Enum

  @code "buy-x-get-one-free"

  def code, do: @code

  defp eligible?(rule, items), do: eligible_qty(rule, items) > 0

  defp eligible_qty(rule, items) do
    div(length(items), rule["quantity"])
  end

  defp apply_rule(rule, items) do
    qty = eligible_qty(rule, items)
    discount_eligible_items(qty, items, [])
  end

  defp discount_eligible_items(_, [], processed) do
    processed
  end

  defp discount_eligible_items(qty, items, processed) when qty == 0 do
    items ++ processed
  end

  defp discount_eligible_items(qty, [item | items], processed) do
    discounted_item = %{item | discount: item.price}
    discount_eligible_items(qty - 1, items, [discounted_item | processed] )
  end
end