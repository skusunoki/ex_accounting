defmodule ExAccounting.State.CurrentAccountingDocumentNumber.Server do
  use GenServer
  alias ExAccounting.State.CurrentAccountingDocumentNumber.DbGateway
  alias ExAccounting.State.CurrentAccountingDocumentNumber.Impl

  def init(_dummy) do
    {:ok, DbGateway.read()}
  end

  def handle_call(:read, _from, current_accounting_document_numbers) do
    {:reply, current_accounting_document_numbers, current_accounting_document_numbers}
  end

  def handle_call({:read, number_range_code}, _from, current_accounting_document_numbers) do
    {:reply, Impl.filter(current_accounting_document_numbers, number_range_code),
     current_accounting_document_numbers}
  end

  def handle_call(
        {:increment, current_document_number},
        _from,
        current_accounting_document_numbers
      ) do
    with incremented =
           Impl.increment(current_document_number, current_accounting_document_numbers),
         filtered = Impl.filter(incremented, current_document_number.number_range_code) do
      {:reply, filtered, incremented}
    end
  end

  def handle_call(
        {:initiate, number_range_code, read_config},
        _from,
        current_accounting_document_numbers
      ) do
    with db <- read_config.(number_range_code),
         initiated <- Impl.initiate(number_range_code, db, current_accounting_document_numbers) do
      {:reply, Impl.filter(initiated, number_range_code), initiated}
    end
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end
end
