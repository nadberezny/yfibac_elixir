defmodule PricingRules.Item do
  @moduledoc false

  @type t :: %__MODULE__{
               code: String.t,
               items: list
             }

  @derive [Poison.Encoder]
  defstruct [:code, :items]

  @spec find(String.t) :: __MODULE__.t
  def find(code) do
    {:ok, item} = PricingRuleRepo.find_by_code(code)
    item
  end
end