defmodule Checkout.InvalidCodeError do
  @moduledoc """
  Raised when non-existing code is passed to Checkout.scan/2
  """

  defexception message: "invalid code"
end
