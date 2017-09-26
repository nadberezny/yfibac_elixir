defmodule Checkout.ItemTest do
  use ExUnit.Case
  doctest Checkout.Item

  test "#find to return item" do
    {:ok, item} = ProductRepo.find_by_code("VOUCHER")
    assert Checkout.Item.find("VOUCHER") == item
  end

  test "#find to raise error when code is non-existing" do
    assert Checkout.Item.find("REHCUOV") == Checkout.InvalidCodeError
  end
end
