defmodule ExAccounting.DataItemDictionary.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.
  """
  @type t :: %__MODULE__{fiscal_year: pos_integer}
  defstruct fiscal_year: nil

  @doc """
    [create] is function for generating valid FiscalYear.

  ## Examples

      iex> FiscalYear.create(2024)
      %FiscalYear{ fiscal_year: 2024 }
  """
  @spec create(pos_integer) :: t()
  def create(fiscal_year)
      when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year < 9999 do
    %__MODULE__{fiscal_year: fiscal_year}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingArea do
  @moduledoc """
  AccountingArea is an organization unit for aggregation (consolidation) of multiple entities.
  """
  @type t :: %__MODULE__{accounting_area: charlist}
  defstruct accounting_area: nil

  @doc """
    [create] is function for generating valid AccountingArea.

  ## Examples

    iex> AccountingArea.create(~C[0001])
    %AccountingArea{ accounting_area: ~C[0001] }
  """
  @spec create(charlist) :: t()
  def create(accounting_area) when accounting_area != nil and length(accounting_area) == 4 do
    %__MODULE__{accounting_area: accounting_area}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumber do
  @moduledoc """
  AccountingDocumentNumber is identification key for accounting document.
  """

  @type t :: %__MODULE__{accounting_document_number: pos_integer}
  defstruct accounting_document_number: nil

  @doc """
    [create] is function for generating valid AccountingDocumentNumber

  ## Examples

    iex> AccountingDocumentNumber.create(1010)
    %AccountingDocumentNumber{accounting_document_number: 1010}
  """
  @spec create(pos_integer) :: t()
  def create(accounting_document_number)
      when is_integer(accounting_document_number) and accounting_document_number > 0 and
             accounting_document_number <= 999_999_999_999 do
    %__MODULE__{accounting_document_number: accounting_document_number}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  @type t :: %__MODULE__{accounting_unit: charlist}
  defstruct accounting_unit: nil

  @doc """
    [create] is function for generating valid AccountingUnit

  ## Examples

    iex> AccountingUnit.create(~C[1000])
    %AccountingUnit{ accounting_unit: ~C[1000]}

  """

  @spec create(charlist) :: t()
  def create(accounting_unit) when length(accounting_unit) == 4 do
    %__MODULE__{accounting_unit: accounting_unit}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingDocumentItemNumber do
  @moduledoc """
  AccountingDocumentItemNumber is identifier of accounting document item
  """

  @type t :: %__MODULE__{accounting_document_item_number: pos_integer}
  defstruct accounting_document_item_number: nil

  @doc """
    [create] is function for generating valid AccountingDocumentNumber.

  ## Examples

    iex> AccountingDocumentItemNumber.create(101)
    %AccountingDocumentItemNumber{accounting_document_item_number: 101}
  """
  @spec create(pos_integer) :: t()
  def create(accounting_document_item_number)
      when is_number(accounting_document_item_number) and accounting_document_item_number > 0 and
             accounting_document_item_number <= 999_999 do
    %__MODULE__{accounting_document_item_number: accounting_document_item_number}
  end
end

defmodule ExAccounting.DataItemDictionary.DebitCredit do
  @moduledoc """
  DebitCredit indicates accounting document item is placed on whether Debitor or Creditor.
  """

  @type t :: %__MODULE__{debit_credit: atom}
  defstruct debit_credit: nil

  @doc """
    [create] is function for generating valid DebitCredit

  ## Examples
    iex> DebitCredit.create(:debit)
    %DebitCredit{debit_credit: :debit}

    iex> DebitCredit.create(:credit)
    %DebitCredit{debit_credit: :credit}

  """
  @spec create(atom) :: t()
  def create(debit_credit)
      when is_atom(debit_credit) and (debit_credit == :debit or debit_credit == :credit) do
    %__MODULE__{debit_credit: debit_credit}
  end
end

defmodule ExAccounting.DataItemDictionary.DocumentType do
  @moduledoc """
  DocumentType categorize accounting document from the point of view of accounting business process.
  """

  @type t :: %__MODULE__{document_type: charlist}
  defstruct document_type: nil

  @doc """
    [create] is function for generating valid document type.

  ## Examples
    iex> DocumentType.create( ~C[DR] )
    %DocumentType{ document_type: ~C[DR]}
  """
  @spec create(charlist) :: t()
  def create(document_type) when is_list(document_type) and length(document_type) == 2 do
    %__MODULE__{document_type: document_type}
  end
end

defmodule ExAccounting.DataItemDictionary.PostingDate do
  @moduledoc """
  PostingDate is the date of accounting document posted.
  """

  @type t :: %__MODULE__{posting_date: Date.t()}
  defstruct posting_date: nil

  @doc """
    [create] is function for generating valid PostingDate.

  ## Examples
    iex> PostingDate.create(~D[2024-08-03])
    %PostingDate{posting_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = posting_date) do
    %__MODULE__{posting_date: posting_date}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingPeriod do
  @type t :: %__MODULE__{accounting_period: pos_integer}
  defstruct accounting_period: nil

  @doc """
    [create] is function for generating valid AccountingPeriod.

  ## Examples
    iex> AccountingPeriod.create(~C[12])
    %AccountingPeriod{accounting_period: 12}

    iex> AccountingPeriod.create(12)
    %AccountingPeriod{accounting_period: 12}

  """
  @spec create(pos_integer) :: t()
  @spec create(charlist) :: t()
  def create(accounting_period)
      when is_list(accounting_period) and
             (accounting_period == ~C[01] or
                accounting_period == ~C[02] or
                accounting_period == ~C[03] or
                accounting_period == ~C[04] or
                accounting_period == ~C[05] or
                accounting_period == ~C[06] or
                accounting_period == ~C[07] or
                accounting_period == ~C[08] or
                accounting_period == ~C[09] or
                accounting_period == ~C[10] or
                accounting_period == ~C[11] or
                accounting_period == ~C[12]) do
    %__MODULE__{
      accounting_period:
        cond do
          accounting_period == ~C[01] -> 1
          accounting_period == ~C[02] -> 2
          accounting_period == ~C[03] -> 3
          accounting_period == ~C[04] -> 4
          accounting_period == ~C[05] -> 5
          accounting_period == ~C[06] -> 6
          accounting_period == ~C[07] -> 7
          accounting_period == ~C[08] -> 8
          accounting_period == ~C[09] -> 9
          accounting_period == ~C[10] -> 10
          accounting_period == ~C[11] -> 11
          accounting_period == ~C[12] -> 12
        end
    }
  end

  def create(accounting_period)
      when is_number(accounting_period) and accounting_period >= 1 and accounting_period <= 12 do
    %__MODULE__{accounting_period: accounting_period}
  end
end

defmodule ExAccounting.DataItemDictionary.DocumentDate do
  @moduledoc """
  DocumentDate is the date of document.
  """

  @type t :: %__MODULE__{document_date: Date.t()}
  defstruct document_date: nil

  @doc """
    [create] is function for generating valid DocumentDate.

  ## Examples
    iex> DocumentDate.create(~D[2024-08-03])
    %DocumentDate{document_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = document_date) do
    %__MODULE__{document_date: document_date}
  end
end

defmodule ExAccounting.DataItemDictionary.EntryDate do
  @moduledoc """
  EntryDate is the date of document created.
  """

  @type t :: %__MODULE__{entry_date: Date.t()}
  defstruct entry_date: nil

  @doc """
    [create] is function for generating valid EntryDate.

  ## Examples

    iex> EntryDate.create(~D[2024-08-03])
    %EntryDate{entry_date: ~D[2024-08-03]}
  """

  @spec create(Date.t()) :: t()
  def create(%Date{} = entry_date) do
    %__MODULE__{entry_date: entry_date}
  end
end

defmodule ExAccounting.DataItemDictionary.EnteredAt do
  @moduledoc """
  EnteredAt is the time of the document created.
  """

  @type t :: %__MODULE__{entered_at: Time.t()}
  defstruct entered_at: nil

  @doc """
    [create] is function for generating valid EnteredAt.

  ## Examples

    iex> EnteredAt.create(~T[12:34:56.00])
    %EnteredAt{entered_at: ~T[12:34:56.00]}
  """
  @spec create(Time.t()) :: t()
  def create(%Time{} = entered_at) do
    %__MODULE__{entered_at: entered_at}
  end
end

defmodule ExAccounting.DataItemDictionary.EnteredBy do
  @moduledoc """
  TODO
  """

  @type t :: %__MODULE__{entered_by: ExAccounting.SystemDictionary.UserName.t()}
  defstruct entered_by: nil

  @doc """
    [create] is function for generating valid EnteredBy.

  ## Exampels

    iex> EnteredBy.create( ExAccounting.SystemDictionary.UserName.create(~C[JohnDoe]))
    %EnteredBy{entered_by: %ExAccounting.SystemDictionary.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(ExAccounting.SystemDictionary.UserName.t()) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = entered_by) do
    %__MODULE__{entered_by: entered_by}
  end
end

defmodule ExAccounting.DataItemDictionary.PostedBy do
  @moduledoc """
  TODO
  """
  @type t :: %__MODULE__{posted_by: ExAccounting.SystemDictionary.UserName.t()}
  defstruct posted_by: nil

  @doc """
    [create] is function for generating valid PostedBy.

  ## Exampels

    iex> PostedBy.create( UserName.create( ~C[JohnDoe]))
    %PostedBy{posted_by: %UserName{ user_name: ~C[johndoe]}}

  """
  @spec create(ExAccounting.SystemDictionary.UserName.t()) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = posted_by) do
    %__MODULE__{posted_by: posted_by}
  end
end

defmodule ExAccounting.DataItemDictionary.AccountingDocument do
  @moduledoc """
  TODO
  """
  @type t :: %__MODULE__{
          accounting_document_header: ExAccounting.AccountingDocumentHeader.t(),
          accounting_document_items: ExAccounting.AccountingDocumentItem.t()
        }
  defstruct accounting_document_header: nil, accounting_document_items: nil

  @spec create(
          ExAccounting.AccountingDocumentHeader.t(),
          ExAccounting.AccountingDocumentItem.t()
        ) ::
          t()
  def create(accounting_document_header, accounting_document_items) do
    %__MODULE__{
      accounting_document_header: accounting_document_header,
      accounting_document_items: accounting_document_items
    }
  end
end
