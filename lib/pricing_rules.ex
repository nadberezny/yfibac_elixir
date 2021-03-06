defmodule PricingRules do
  @moduledoc """
  This module is intended to be included in specific pricing rules modules as
  a set of common functions needed for pricing calculation.
  A module that declares `use` of PricingRules must implement three functions:
  `code/0`, `eligible/2` and `apply_rule/2`.
  """

  defmacro __using__(_opts) do
    quote do
      @behaviour PricingRuleBehaviour

      import Enum

      def apply_rule(checkout) do
        %{checkout |
          items: calculate_items(checkout.items)
        }
      end

      defp calculate_items(items) do
        groups = group_by_code(items)
        calculated_groups = map(groups, &(calculate_item_group(&1)))
        flatten(calculated_groups)
      end

      defp group_by_code(items) do
        groups = group_by(items, &(&1.code))
        to_list(groups)
      end

      defp flatten(groups),
        do: reduce(groups, &(&1 ++ &2))

      defp calculate_item_group({code, items}) do
        rule = find_rule(code)

        if rule && eligible?(rule, items) do
          apply_rule(rule, items)
        else
          items
        end
      end

      defp find_rule(code) do
        rule_code = code()
        rule = PricingRules.Item.find(rule_code)
        find(rule.items, &(&1["code"] == code))
      end
    end
  end
end
