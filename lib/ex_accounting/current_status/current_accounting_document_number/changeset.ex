defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Changeset do
  import Ecto.Changeset
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode

  @typedoc "Next document number which is incremented or newly created from the configuration of the accounting document number range."
  @type current_document_number :: %{
          number_range_code: AccountingDocumentNumberRangeCode.t(),
          current_document_number: AccountingDocumentNumber.t()
        }
  @doc """
  Makes the changeset for the current accounting document number.
  """

  @spec changeset(CurrentAccountingDocumentNumber.t(), %{}) :: Ecto.Changeset.t()
  @spec changeset(CurrentAccountingDocumentNumber.t(), current_document_number) ::
          Ecto.Changeset.t()
  def changeset(current_accounting_document_number, params \\ %{}) do
    current_accounting_document_number
    |> cast(params, [:number_range_code, :current_document_number])
    |> unique_constraint(:number_range_code)
  end

  @doc """
  Makes the changeset for the current accounting document number.
  The argument should be a tuple with the first element as the action to be taken to the database whether to insert or update.
  """
  @spec make_changeset({:insert, CurrentAccountingDocumentNumber.t(), current_document_number}) ::
          {:insert, Ecto.Changeset.t()}
  @spec make_changeset({:update, CurrentAccountingDocumentNumber.t(), current_document_number}) ::
          {:update, Ecto.Changeset.t()}
  def make_changeset({:insert, _, after_updated}) do
    {:insert, changeset(%CurrentAccountingDocumentNumber{}, after_updated)}
  end

  def make_changeset({:update, before_updated, after_updated}) do
    {:update, changeset(before_updated, after_updated)}
  end
end
