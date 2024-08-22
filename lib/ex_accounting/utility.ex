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
  Check if the input charactor is alphanumeric.

  1st argument is charactor to be validated. 2nd argument is the successful result value.

  ## Examples

      iex> for x <- ~c[A1x] do ExAccounting.Utility.is_valid_charactor(x, :ok) end
      [:ok, :ok, :error]

      iex> ~c[A1x] |> Enum.reduce(:ok, &ExAccounting.Utility.is_valid_charactor(&1, &2) )
      :error

      iex> ~c[xA1] |> Enum.reduce(:ok, &ExAccounting.Utility.is_valid_charactor(&1, &2) )
      :error

      iex> ~c[XA1] |> Enum.reduce(:ok, &ExAccounting.Utility.is_valid_charactor(&1, &2) )
      :ok

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

  @doc """
  Measure length of list or strings

  ## Examples

      iex> ExAccounting.Utility.len([1,2,3])
      3

      iex> ExAccounting.Utility.len("abc")
      3

  """
  @spec len(list | String.t()) :: integer()
  def len(term) when is_list(term) do
    length(term)
  end

  def len(term) when is_binary(term) do
    String.length(term)
  end

  @doc """
  Cast to charlist.

  ## Examples

      iex> ExAccounting.Utility.to_c("abc")
      ~C[abc]

      iex> ExAccounting.Utility.to_c(~C[abc])
      ~C[abc]
  """
  @spec to_c(list | String.t()) :: charlist()
  def to_c(term) when is_list(term) do
    term
  end

  def to_c(term) when is_binary(term) do
    to_charlist(term)
  end
end
