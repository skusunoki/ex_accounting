defmodule ExAccounting.Elem.OffsettingPaymentService do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          offsetting_payment_service: charlist()
        }
  defstruct offsetting_payment_service: nil

  def type, do: :string

  def cast(%__MODULE__{} = offsetting_payment_service), do: {:ok, offsetting_payment_service}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_payment_service: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_payment_service: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = offsetting_payment_service),
    do: {:ok, to_string(offsetting_payment_service.offsetting_payment_service)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{offsetting_payment_service: validated}}
    else
      _ -> :error
    end
  end
end
