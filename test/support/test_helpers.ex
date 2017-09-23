defmodule TestHelpers do
  @moduledoc false

  import Enum

  def discount_total(items), do: map(items, &(&1.discount)) |> reduce(&(&1 + &2))

  def scan_codes(checkout, []), do: checkout
  def scan_codes(checkout, [code | codes]) do
    checkout = Checkout.scan(checkout, code)
    scan_codes(checkout, codes)
  end
end