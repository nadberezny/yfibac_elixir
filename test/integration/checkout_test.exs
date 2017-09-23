defmodule CheckoutTest do
  use ExUnit.Case
  doctest Checkout

  test "scan" do
    for {codes, total} <- %{
      ~W/VOUCHER TSHIRT MUG/ => 32.5,
      ~W/VOUCHER TSHIRT VOUCHER/ => 25.0,
      ~W/TSHIRT TSHIRT TSHIRT VOUCHER TSHIRT/ => 81.0,
      ~W/VOUCHER TSHIRT VOUCHER VOUCHER MUG TSHIRT TSHIRT/ => 74.5,
    } do
      checkout = TestHelpers.scan_codes(%Checkout{}, codes)
      assert checkout.total == total
    end
  end
end
