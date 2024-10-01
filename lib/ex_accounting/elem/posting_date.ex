defmodule ExAccounting.Elem.PostingDate do
  @moduledoc """
  _Posting Date_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.
  """
  use ExAccounting.Type
  date(:posting_date, description: "Posting Date")
end
