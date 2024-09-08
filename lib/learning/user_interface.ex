defmodule Learning.UserInterface do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:amount1, :integer)
    field(:currency1, :string)
    field(:amount2, :integer)
    field(:currency2, :string)
  end

  def changeset(user_interface, params) do
    with changeset =
           user_interface
           |> cast(params, [:amount1, :currency1, :amount2, :currency2])
           |> validate_required([:amount1, :currency1, :amount2, :currency2]),
         [] <- changeset.errors,
         params = %{
           item: nil,
           transaction_amount: %{amount: params.amount1, currency: params.currency1},
           accounting_amount: %{amount: params.amount2, currency: params.currency2}
         } do
      Learning.DocumentItem.changeset(%Learning.DocumentItem{}, params)
    end
  end
end
