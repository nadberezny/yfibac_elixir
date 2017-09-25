defmodule Checkout do
  @moduledoc """
  Provides interface for code scanning and total calculation.
  Pricing rules by default are taken from PricingRules.Manifest.
  They also can be passed to Struct directly.
  Through all scan operation one data type is passed, which is Checkout.t

  ## Examples
      iex> co = %Checkout{}
      iex> co = Checkout.scan(co, "VOUCHER")
      iex> co = Checkout.scan(co, "VOUCHER")
      iex> co.total
      5.0
  """

  import Enum

  alias Checkout.Item, as: Item

  @type t :: %__MODULE__{
               items: list(Checkout.Item.t),
               pricing_rules: list,
               total: number
             }

  defstruct [
    items: [],
    pricing_rules: PricingRules.Manifest.active_rules,
    total: 0
  ]

  @spec scan(__MODULE__.t, String.t) :: __MODULE__.t
  def scan(checkout, code) do
    checkout
    |> reset_discounts
    |> add_item(Item.find(code))
    |> apply_pricing_rules
    |> calculate_total
  end

  defp reset_discounts(checkout) do
    %{checkout |
      items: for item <- checkout.items do %{item | discount: 0} end
    }
  end

  defp add_item(checkout, item) do
    %{checkout |
      items: [item | checkout.items]
     }
  end

  defp apply_pricing_rules(checkout),
    do: apply_pricing_rules(checkout, checkout.pricing_rules)
  defp apply_pricing_rules(checkout, []),
    do: checkout
  defp apply_pricing_rules(checkout, [rule | rules]),
    do: apply_pricing_rules(rule.apply_rule(checkout), rules)

  defp calculate_total(checkout) do
    %{checkout |
      total: items_total(checkout.items)
     }
  end

  defp items_total(items) do
    prices = map(items, &(&1.price - &1.discount))
    reduce(prices, &(&1 + &2))
  end
end
