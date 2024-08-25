defmodule ExAccounting.Elem.AccountingArea do
  @moduledoc """
  _Accounting Area_ is an organization unit for aggregation (consolidation) of multiple entities.
  """
  use Ecto.Type
  defstruct accounting_area: nil

  @typedoc "_Accounting Area_ : an organization unit for aggregation (consolidation) of multiple entities."
  @type t :: %__MODULE__{accounting_area: charlist}

  @doc """
  Defines the database field type of _Accounting Area_ as `:string`.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given charlist or strings to the _Accounting Area_.
  The argument must be alphanumeric 4 letters. Lower case letters are not allowed.

  ## Examples
      iex> cast(~C[0001])
      {:ok, %AccountingArea{accounting_area: ~C[0001] }}

      iex> cast("0001")
      {:ok, %AccountingArea{accounting_area: ~C[0001] }}

      iex> cast(0001)
      {:error, 0001}

      iex> cast(%ExAccounting.Elem.AccountingArea{accounting_area: ~c[x1]})
      {:error, %ExAccounting.Elem.AccountingArea{accounting_area: ~c[x1]}}

  """
  @spec cast(t) :: {:ok, t} | :error
  @spec cast(String.t() | charlist) :: {:ok, t} | :error
  def cast(%__MODULE__{} = term) do
    with %__MODULE__{accounting_area: code} <- term,
         {:ok, _} <- validate(code) do
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

  @doc """
  Loads the _Accounting Area_ from the given binary data.

  ## Examples
      iex> load("0001")
      {:ok, %AccountingArea{accounting_area: ~C[0001]}}
  """
  @spec load(binary) :: {:ok, t} | :error
  def load(data) when is_binary(data) do
    with stdata = %{accounting_area: to_charlist(data)}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  @doc """
  Dumps _Accounting Area_ into the database form.

  ## Examples

      iex> dump(%AccountingArea{accounting_area: ~C[0001]})
      {:ok, "0001"}
  """
  @spec dump(t) :: binary() | :error
  def dump(term) do
    with %__MODULE__{accounting_area: code} <- term,
         {:ok, _validated} <- validate(code),
         dump = code |> to_string() do
      {:ok, dump}
    else
      _ -> :error
    end
  end

  @doc """
  Evaluates the two given __Accounting Area__ are equal.

  ## Examples

      iex> equal?(%AccountingArea{accounting_area: ~C[0001]}, %AccountingArea{accounting_area: ~C[0001]})
      true
  """
  @spec equal?(term1 :: t, term2 :: t) :: boolean()
  def equal?(
        %__MODULE__{accounting_area: code1} = _term1,
        %__MODULE__{accounting_area: code2} = _term2
      ) do
    code1 == code2
  end

  @doc """
  Generates the valid _Accounting Area_ from the given charlist or strings.

  ## Examples
      iex> create(~C[0001])
      %AccountingArea{accounting_area: ~C[0001]}
  """
  @spec create(charlist) :: t()
  def create(term)
      when term != nil and is_list(term) and length(term) == 4 do
    %__MODULE__{accounting_area: term}
  end

  @spec create(binary) :: t()
  def create(term) when is_binary(term) and term != nil do
    term
    |> to_charlist()
    |> create()
  end

  @doc """
  Validates the given _Accounting Area_.

  The length of _Accounting Area_ must be 4.
  The letters of alphanumeric are allowed.

  ## Examples
      iex> AccountingArea.validate(~C[0001])
      {:ok, ~C[0001]}
  """
  def validate(code) do
    with true <- code != nil,
         true <- is_list(code),
         true <- ExAccounting.Utility.len(code) == 4,
         {:ok, _validated} <- ExAccounting.Utility.validate(code) do
      {:ok, code}
    else
      false -> {:error, code}
      {:error, reason} -> {:error, reason}
    end
  end
end
