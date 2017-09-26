defmodule ProductRepoTest do
  use ExUnit.Case
  doctest ProductRepo

  test "#find_by_code to return :ok struct with item when product exists" do
    item = %Checkout.Item{code: "VOUCHER", discount: 0, name: "Cabify Voucher", price: 5.0}
    assert {:ok, item} == ProductRepo.find_by_code("VOUCHER")
  end

  test "#find to return :error with nil when product is non-existing" do
    assert {:error, nil} == ProductRepo.find_by_code("REHCUOV")
  end
end
