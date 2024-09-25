defmodule Learning.Type do
  defmacro __using__(_opts) do
    quote do
      import Learning.Type
    end
  end

  defmacro code(module, field, type, length) do
    quote do
      defmodule unquote(module) do
        @moduledoc """
        _#{unquote(module)}_ is identifier of a #{unquote(module)}.
        """
        use Ecto.Type
        defstruct [unquote(field)]
        def type, do: unquote(type)

        def cast(%__MODULE__{} = term) do
          with %__MODULE__{unquote(field) => code} <- term,
               {:ok, validated} <- validate(code) do
            {:ok, term}
          else
            {:error, _reason} -> {:error, term}
            _ -> :error
          end
        end

        def cast(term) do
          with true <- is_list(term) or is_binary(term),
               {:ok, _} <- validate(ExAccounting.Utility.to_c(term)) do
            {:ok, create(term)}
          else
            _ -> {:error, term}
          end
        end

        def load(data) when is_binary(data) do
          with stdata = %{unquote(field) => to_charlist(data)},
            do: {:ok, struct!(__MODULE__, stdata)}
        end

        def dump(term) do
          with %__MODULE__{unquote(field) => code} <- term,
               {:ok, _validated} <- validate(code),
               dump = code |> to_string() do
            {:ok, dump}
          else
            _ -> :error
          end
        end

        def create(term)
            when term != nil and is_list(term) and length(term) == unquote(length) do
          %__MODULE__{unquote(field) => term}
        end

        def create(term) when is_binary(term) and term != nil do
          term
          |> to_charlist()
          |> create()
        end

        def validate(code) do
          with true <- code != nil,
               true <- is_list(code),
               true <- ExAccounting.Utility.len(code) == unquote(length),
               {:ok, _validated} <- ExAccounting.Utility.validate(code) do
            {:ok, code}
          else
            false -> {:error, code}
            {:error, reason} -> {:error, reason}
          end
        end
      end
    end
  end
end
