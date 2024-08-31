defmodule ExAccounting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExAccounting.Repo,
      %{
        id: ExAccounting.Configuration.CurrencyConfiguration,
        start: {ExAccounting.Configuration.CurrencyConfiguration, :start_link, [:init]}
      },
      %{
        id: ExAccounting.Configuration.AccountingDocumentNumberRange,
        start: {ExAccounting.Configuration.AccountingDocumentNumberRange, :start_link, [:init]}
      },
      %{
        id: ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber,
        start: {ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber, :start_link, [:init]}
      }


      # Starts a worker by calling: ElAccountingGl.Worker.start_link(arg)
      # {ElAccountingGl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAccounting.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
