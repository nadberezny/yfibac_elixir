defmodule Cabify do
  @docmodule false

  @db_path Path.expand("./db/cabify_db.json")

  def db_path, do: @db_path
end