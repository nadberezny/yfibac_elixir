defmodule RepositoryBehaviour do
  @moduledoc false

  @callback relation() :: String.t
  @callback returning_type() :: any
end
