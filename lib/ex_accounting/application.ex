defmodule ExAccounting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExAccounting.Repo,
      ExAccounting.Configuration.CurrencyConfiguration.Server,
      ExAccounting.Configuration.AccountingDocumentNumberRange.Server,
      ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Server
    ]

    opts = [strategy: :one_for_one, name: ExAccounting.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
