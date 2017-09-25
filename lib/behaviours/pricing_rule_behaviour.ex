defmodule PricingRuleBehaviour do
  @moduledoc false

  @callback apply_rule(Checkout.t) :: Checkout.t
end
