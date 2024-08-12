defmodule ExAccounting.Utility do
  @doc """
  short code system only allows alphanumeric charactors.

  ## Examples

    iex> ExAccounting.Utility.validate(~c[A1])
    {:ok, ~c[A1]}

    iex> ExAccounting.Utility.validate(~c[x0])
    {:error, ~c[x0]}

  """
  @spec validate(charlist) :: {:ok, charlist} | {:error, charlist}
  def validate(accounting_document_number_range_code) do
    {
      accounting_document_number_range_code
      |> Enum.reduce(:ok, &is_valid_charactor(&1, &2)),
      accounting_document_number_range_code
    }
  end

  @doc """

  ## Examples

    iex> for x <- ~c[A1x] do ExAccounting.Utility.is_valid_charactor(x, :ok) end
    [:ok, :ok, :error]

  """
  @spec is_valid_charactor(char, :ok | :error) :: :ok | :error
  def is_valid_charactor(input, result_of_previous) do
    with valid_charactors = ~c[ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789] do
      case input in valid_charactors do
        true -> result_of_previous
        false -> :error
      end
    end
  end
end
