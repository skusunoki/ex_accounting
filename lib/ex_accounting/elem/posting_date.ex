defmodule ExAccounting.Elem.PostingDate do
  @moduledoc """
  _Posting Date_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.

  ## Examples

      iex> ExAccounting.Elem.PostingDate.cast(~D[2020-01-01])
      {:ok, %ExAccounting.Elem.PostingDate{posting_date: ~D[2020-01-01]}}
  """
  use ExAccounting.Type
  date(:posting_date, description: "Posting Date")
end
