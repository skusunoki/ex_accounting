defmodule ExAccounting.Configuration.AccountingDocumentNumberRange.Server do
  @moduledoc false
  use GenServer
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.Impl
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.DbGateway

  def init(_args) do
    {:ok, DbGateway.read()}
  end

  def handle_call(:read, _from, accounting_document_number_ranges) do
    {:reply, accounting_document_number_ranges, accounting_document_number_ranges}
  end

  def handle_call({:read, number_range_code}, _from, accounting_document_number_ranges) do
    {:reply, Impl.filter(accounting_document_number_ranges, number_range_code),
     accounting_document_number_ranges}
  end

  def handle_call(
        {:modify, accounting_document_number_range, accounting_document_number_from,
         accounting_document_number_to},
        _from,
        accounting_document_number_ranges
      ) do
    {:reply, accounting_document_number_ranges,
     Impl.modify(
       accounting_document_number_ranges,
       accounting_document_number_range,
       accounting_document_number_from,
       accounting_document_number_to
     )}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end
end
