defmodule ExAccounting.JournalEntryPerformanceTest do
  use ExUnit.Case, async: false
  alias ExAccounting.EmbeddedSchema.JournalEntry
  alias ExAccounting.Schema.AccountingDocumentItem
  alias ExAccounting.Repo

  setup do
    # Sandbox each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ExAccounting.Repo)
    
    {:ok, %{}}
  end

  describe "Performance Tests" do
    @tag :performance
    test "processes large batch of journal entries efficiently" do
      # Arrange - Create 1000 journal entries
      batch_size = 1000
      
      journal_entries = Enum.map(1..batch_size, fn i ->
        create_test_journal_entry_params(i)
      end)

      # Act - Measure processing time
      {time_microseconds, results} = :timer.tc(fn ->
        Enum.map(journal_entries, fn params ->
          changeset = JournalEntry.changeset(%JournalEntry{}, params)
          assert changeset.valid?, "Journal entry #{inspect(params)} should be valid"
          changeset
        end)
      end)

      # Assert - Should process within reasonable time (< 5 seconds)
      time_seconds = time_microseconds / 1_000_000
      assert time_seconds < 5.0, "Batch processing took #{time_seconds} seconds, should be < 5 seconds"
      assert length(results) == batch_size
      
      IO.puts("Processed #{batch_size} journal entries in #{time_seconds} seconds")
      IO.puts("Average time per entry: #{time_microseconds / batch_size / 1000} ms")
    end

    @tag :performance
    test "handles concurrent journal entry creation" do
      # Arrange - Create concurrent tasks
      task_count = 10
      entries_per_task = 50

      # Act - Run concurrent tasks
      {time_microseconds, results} = :timer.tc(fn ->
        1..task_count
        |> Enum.map(fn task_id ->
          Task.async(fn ->
            Enum.map(1..entries_per_task, fn i ->
              unique_id = task_id * 1000 + i
              params = create_test_journal_entry_params(unique_id)
              changeset = JournalEntry.changeset(%JournalEntry{}, params)
              assert changeset.valid?
              changeset
            end)
          end)
        end)
        |> Enum.map(&Task.await(&1, 10000))
      end)

      # Assert
      total_entries = task_count * entries_per_task
      time_seconds = time_microseconds / 1_000_000
      assert time_seconds < 10.0, "Concurrent processing took #{time_seconds} seconds"
      assert length(results) == task_count
      
      total_processed = results |> List.flatten() |> length()
      assert total_processed == total_entries
      
      IO.puts("Processed #{total_entries} entries concurrently in #{time_seconds} seconds")
      IO.puts("Throughput: #{total_entries / time_seconds} entries/second")
    end

    @tag :performance
    test "database insertion performance for large transaction volumes" do
      # Skip this test if not in performance mode
      unless System.get_env("RUN_PERFORMANCE_TESTS") do
        IO.puts("Skipping performance test - set RUN_PERFORMANCE_TESTS=1 to run")
        assert true
        return
      end

      # Arrange - Prepare large batch of accounting items
      batch_size = 5000
      
      accounting_items = Enum.map(1..batch_size, fn i ->
        %{
          fiscal_year: 2024,
          accounting_area: "0001",
          accounting_document_number: 2000000 + div(i, 2),  # 2 items per document
          accounting_unit: "1000",
          accounting_document_item_number: rem(i, 2) + 1,
          debit_credit: if(rem(i, 2) == 0, do: "S", else: "H"),
          document_type: "SA",
          posting_date: ~D[2024-01-15],
          general_ledger_account: if(rem(i, 2) == 0, do: "100000", else: "400000"),
          amount_in_transaction_currency: Decimal.new("1000.00"),
          transaction_currency: "USD"
        }
      end)

      # Act - Batch insert with timing
      {time_microseconds, _results} = :timer.tc(fn ->
        # Use insert_all for better performance
        Repo.insert_all(AccountingDocumentItem, accounting_items)
      end)

      # Assert
      time_seconds = time_microseconds / 1_000_000
      assert time_seconds < 30.0, "Batch insertion took #{time_seconds} seconds"
      
      # Verify insertion
      count = Repo.aggregate(AccountingDocumentItem, :count, :id)
      assert count >= batch_size
      
      throughput = batch_size / time_seconds
      IO.puts("Inserted #{batch_size} accounting items in #{time_seconds} seconds")
      IO.puts("Database throughput: #{throughput} records/second")
    end

    @tag :performance
    test "memory usage for complex journal entries" do
      # Arrange - Create complex journal entry with many items
      complex_entry_params = create_complex_journal_entry_params(50)  # 50 line items

      # Act - Monitor memory during processing
      initial_memory = :erlang.memory(:total)
      
      changeset = JournalEntry.changeset(%JournalEntry{}, complex_entry_params)
      assert changeset.valid?
      
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      final_memory = :erlang.memory(:total)
      memory_used = final_memory - initial_memory

      # Assert - Memory usage should be reasonable
      memory_mb = memory_used / (1024 * 1024)
      assert memory_mb < 50, "Memory usage of #{memory_mb}MB is too high"
      
      # Verify structure is correct
      assert length(journal_entry.item) == 50
      
      IO.puts("Complex journal entry used #{memory_mb}MB of memory")
    end

    @tag :performance
    test "validation performance for unbalanced entries" do
      # Arrange - Create intentionally unbalanced entries
      batch_size = 500
      
      unbalanced_entries = Enum.map(1..batch_size, fn i ->
        create_unbalanced_journal_entry_params(i)
      end)

      # Act - Measure validation time
      {time_microseconds, results} = :timer.tc(fn ->
        Enum.map(unbalanced_entries, fn params ->
          changeset = JournalEntry.changeset(%JournalEntry{}, params)
          refute changeset.valid?, "Entry should be invalid due to imbalance"
          changeset
        end)
      end)

      # Assert
      time_seconds = time_microseconds / 1_000_000
      assert time_seconds < 3.0, "Validation took #{time_seconds} seconds"
      assert length(results) == batch_size
      
      # All should have validation errors
      error_count = Enum.count(results, &(!&1.valid?))
      assert error_count == batch_size
      
      IO.puts("Validated #{batch_size} unbalanced entries in #{time_seconds} seconds")
    end

    @tag :performance
    test "query performance for large datasets" do
      # Skip this test if not in performance mode
      unless System.get_env("RUN_PERFORMANCE_TESTS") do
        IO.puts("Skipping performance test - set RUN_PERFORMANCE_TESTS=1 to run")
        assert true
        return
      end

      # Arrange - Insert test data
      batch_size = 10000
      test_data = Enum.map(1..batch_size, fn i ->
        %{
          fiscal_year: 2024,
          accounting_area: "0001",
          accounting_document_number: 3000000 + i,
          accounting_unit: "1000",
          accounting_document_item_number: 1,
          debit_credit: if(rem(i, 2) == 0, do: "S", else: "H"),
          document_type: "SA",
          posting_date: ~D[2024-01-15],
          general_ledger_account: Enum.random(["100000", "130000", "400000", "520000"]),
          amount_in_transaction_currency: Decimal.new("#{100 + rem(i, 900)}.00"),
          transaction_currency: "USD",
          inserted_at: NaiveDateTime.utc_now(),
          updated_at: NaiveDateTime.utc_now()
        }
      end)

      {insert_time, _} = :timer.tc(fn ->
        Repo.insert_all(AccountingDocumentItem, test_data)
      end)

      # Act - Test various query patterns
      queries = [
        # Simple filter
        fn -> 
          from(a in AccountingDocumentItem, 
               where: a.general_ledger_account == "100000")
          |> Repo.all()
        end,
        
        # Date range query
        fn ->
          from(a in AccountingDocumentItem,
               where: a.posting_date >= ^~D[2024-01-01] and a.posting_date <= ^~D[2024-01-31])
          |> Repo.all()
        end,
        
        # Aggregation query
        fn ->
          from(a in AccountingDocumentItem,
               group_by: a.general_ledger_account,
               select: {a.general_ledger_account, sum(a.amount_in_transaction_currency)})
          |> Repo.all()
        end,
        
        # Complex join-like query
        fn ->
          from(a in AccountingDocumentItem,
               where: a.debit_credit == "S" and a.amount_in_transaction_currency > 500,
               order_by: [desc: a.amount_in_transaction_currency],
               limit: 100)
          |> Repo.all()
        end
      ]

      query_times = Enum.map(queries, fn query_fn ->
        {time, results} = :timer.tc(query_fn)
        {time / 1000, length(results)}  # Convert to milliseconds
      end)

      # Assert - All queries should complete within reasonable time
      Enum.each(query_times, fn {time_ms, count} ->
        assert time_ms < 1000, "Query took #{time_ms}ms, should be < 1000ms"
        assert count >= 0
      end)

      IO.puts("Dataset size: #{batch_size} records")
      IO.puts("Insert time: #{insert_time / 1_000_000} seconds")
      IO.puts("Query performance:")
      
      query_names = ["Filter query", "Date range", "Aggregation", "Complex filter"]
      Enum.zip(query_names, query_times)
      |> Enum.each(fn {name, {time_ms, count}} ->
        IO.puts("  #{name}: #{time_ms}ms (#{count} results)")
      end)
    end
  end

  # Helper functions for test data creation
  defp create_test_journal_entry_params(id) do
    %{
      header: %{
        accounting_unit_attr: %{
          accounting_area: %{accounting_area: "0001"},
          accounting_unit: "1000"
        },
        transaction_currency: "USD",
        document_type: "SA",
        posting_date: ~D[2024-01-15]
      },
      item: [
        %{
          general_ledger_transaction: %{
            general_ledger_account: "100000",
            debit_credit: %{debit_credit: :debit},
            transaction_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            },
            accounting_area_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            }
          }
        },
        %{
          general_ledger_transaction: %{
            general_ledger_account: "400000",
            debit_credit: %{debit_credit: :credit},
            transaction_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            },
            accounting_area_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            }
          }
        }
      ]
    }
  end

  defp create_complex_journal_entry_params(item_count) do
    # Create a complex entry with multiple line items
    # Half debits, half credits, balanced
    debit_count = div(item_count, 2)
    credit_count = item_count - debit_count
    amount_per_item = Decimal.new("100.00")

    debit_items = Enum.map(1..debit_count, fn i ->
      %{
        general_ledger_transaction: %{
          general_ledger_account: "10#{String.pad_leading("#{i}", 4, "0")}",
          debit_credit: %{debit_credit: :debit},
          transaction_value: %{
            amount: amount_per_item,
            currency: "USD"
          },
          accounting_area_value: %{
            amount: amount_per_item,
            currency: "USD"
          }
        },
        cost_center_transaction: %{
          cost_center: "CC#{String.pad_leading("#{i}", 3, "0")}",
          cost_center_transaction_type: "01"
        }
      }
    end)

    total_debit_amount = Decimal.mult(amount_per_item, debit_count)
    amount_per_credit = Decimal.div(total_debit_amount, credit_count)

    credit_items = Enum.map(1..credit_count, fn i ->
      %{
        general_ledger_transaction: %{
          general_ledger_account: "40#{String.pad_leading("#{i}", 4, "0")}",
          debit_credit: %{debit_credit: :credit},
          transaction_value: %{
            amount: amount_per_credit,
            currency: "USD"
          },
          accounting_area_value: %{
            amount: amount_per_credit,
            currency: "USD"
          }
        }
      }
    end)

    %{
      header: %{
        accounting_unit_attr: %{
          accounting_area: %{accounting_area: "0001"},
          accounting_unit: "1000"
        },
        transaction_currency: "USD",
        document_type: "SA",
        posting_date: ~D[2024-01-15]
      },
      item: debit_items ++ credit_items
    }
  end

  defp create_unbalanced_journal_entry_params(id) do
    %{
      header: %{
        accounting_unit_attr: %{
          accounting_area: %{accounting_area: "0001"},
          accounting_unit: "1000"
        },
        transaction_currency: "USD",
        document_type: "SA",
        posting_date: ~D[2024-01-15]
      },
      item: [
        %{
          general_ledger_transaction: %{
            general_ledger_account: "100000",
            debit_credit: %{debit_credit: :debit},
            transaction_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            },
            accounting_area_value: %{
              amount: Decimal.new("#{1000 + id}.00"),
              currency: "USD"
            }
          }
        },
        %{
          general_ledger_transaction: %{
            general_ledger_account: "400000",
            debit_credit: %{debit_credit: :credit},
            transaction_value: %{
              # Intentionally unbalanced - different amount
              amount: Decimal.new("#{800 + id}.00"),
              currency: "USD"
            },
            accounting_area_value: %{
              amount: Decimal.new("#{800 + id}.00"),
              currency: "USD"
            }
          }
        }
      ]
    }
  end
end