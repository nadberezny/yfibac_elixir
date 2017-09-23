defmodule PricingRuleBehaviour do
  @moduledoc false

  @callback apply(Checkout.t) :: Checkout.t
end