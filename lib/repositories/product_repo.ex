defmodule ProductRepo do
  @moduledoc false

  @behaviour RepositoryBehaviour

  use Repository

  @relation "products"
  @returning_type %Checkout.Item{}

  def relation, do: @relation
  def returning_type, do: @returning_type
end
