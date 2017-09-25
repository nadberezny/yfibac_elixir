defmodule Repository do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @spec find_by_code(String.t) :: {:ok, any} | {:error, nil}
      def find_by_code(code) do
        result = Enum.find(all(), &(&1.code == code))
        find_result(result)
      end

      defp all do
        {:ok, file} = File.read(Cabify.db_path)
        decode_params = %{relation() => [returning_type()]}
        {:ok, items} = Poison.decode(file, as: decode_params)
        items[relation()]
      end

      defp find_result(nil), do: {:error, nil}
      defp find_result(item), do: {:ok, item}
    end
  end
end
