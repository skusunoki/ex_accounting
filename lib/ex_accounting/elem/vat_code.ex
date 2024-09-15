defmodule ExAccounting.Elem.VatCode do
  use Ecto.Type

  @type t :: %__MODULE__{
          vat_code: charlist()
        }

  defstruct vat_code: nil

  def type, do: :string

  def cast(%__MODULE__{} = vat_code),
    do: {:ok, vat_code}

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 2 do
      {:ok, %__MODULE__{vat_code: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 2 do
      {:ok, %__MODULE__{vat_code: validated}}
    else
      _ -> :error
    end
  end

  def dump(%__MODULE__{} = vat_code),
    do: {:ok, to_string(vat_code.vat_code)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 2 do
      {:ok, %__MODULE__{vat_code: validated}}
    else
      _ -> :error
    end
  end
end
