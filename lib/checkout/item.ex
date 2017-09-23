defmodule Checkout.Item do
  @moduledoc false

  @type t :: %__MODULE__{
               code: String.t,
               name: String.t | nil,
               price: number,
               discount: number
             }

  @derive [Poison.Encoder]
  defstruct [:code, :name, :price, discount: 0]

  @spec find(String.t) :: __MODULE__.t
  def find(code) do
    {:ok, item} = ProductRepo.find_by_code(code)
    item
  end
end
