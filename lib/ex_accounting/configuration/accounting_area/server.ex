defmodule ExAccounting.Configuration.AccountingArea.Server do
  use GenServer
  alias ExAccounting.Configuration.AccountingArea.DbGateway
  alias ExAccounting.Configuration.AccountingArea.AccountingUnit
  import Ecto.Changeset

  @spec init(any()) :: {:ok, [Ecto.Changeset.t()]}
  def init(_args) do
    {:ok, changeset_from_db_read()}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end

  def handle_call(:read, _from, accounting_areas) do
    {:reply, apply_changes_to_list(accounting_areas), accounting_areas}
  end

  def handle_call({:read, accounting_area}, _from, accounting_areas) do
    with {:ok, accounting_area} <- ExAccounting.Elem.AccountingArea.cast(accounting_area),
         data when not is_nil(data) <- find_by_accounting_area(accounting_areas, accounting_area) do
      {:reply, apply_changes(data), accounting_areas}
    else
      _ -> {:reply, {:error, "Accounting area not found"}, accounting_areas}
    end
  end

  def handle_call(
        {:add_accounting_area,
         %{accounting_area: _accounting_area, accounting_area_currency: _accounting_area_currency} =
           addend_param},
        _from,
        accounting_areas
      ) do
    changeset =
      ExAccounting.Configuration.AccountingArea.Changeset.add_accounting_area(addend_param)

    {:reply, changeset, append_to_list(accounting_areas, changeset)}
  end

  def handle_call(
        {:add_accounting_unit, accounting_area,
         %{
           accounting_unit: _accounting_unit,
           accounting_unit_currency: _accounting_unit_currency
         } = append_param},
        _from,
        accounting_areas
      ) do
    with {:ok, accounting_area} <- ExAccounting.Elem.AccountingArea.cast(accounting_area),
         data when not is_nil(data) <- find_by_accounting_area(accounting_areas, accounting_area),
         changeset =
           data
           |> cast(
             get_accounting_units(data) |> build_param_of_accounting_units(append_param),
             []
           )
           |> cast_assoc(:accounting_units,
             with: &AccountingUnit.changeset/2
           ) do
      {:reply, changeset, modify_list(changeset, accounting_areas, data)}
    else
      _ -> {:reply, {:error, "Accounting area not found"}, accounting_areas}
    end
  end

  def handle_call(:save, _from, accounting_areas) do
    for x <- accounting_areas do
      DbGateway.save(x)
    end

    {:reply, :ok, changeset_from_db_read()}
  end

  defp changeset_from_db_read() do
    DbGateway.read() |> Enum.map(fn x -> Ecto.Changeset.cast(x, %{}, []) end)
  end

  defp apply_changes_to_list(changesets) do
    Enum.map(changesets, fn x -> Ecto.Changeset.apply_changes(x) end)
  end

  defp find_by_accounting_area(changesets, accounting_area) do
    Enum.find(changesets, fn x ->
      Ecto.Changeset.get_field(x, :accounting_area) == accounting_area
    end)
  end

  defp append_to_list(changesets, changeset) do
    [changeset | changesets]
  end

  defp modify_list(changeset, changesets, removal) do
    [changeset | changesets -- [removal]]
  end

  defp get_accounting_units(changeset) do
    apply_changes(changeset) |> Map.get(:accounting_units)
  end

  defp build_param_of_accounting_units(accounting_units, append_param) do
    %{
      accounting_units:
        Enum.map(accounting_units, fn x -> Map.from_struct(x) end) ++
          [append_param]
    }
  end
end
