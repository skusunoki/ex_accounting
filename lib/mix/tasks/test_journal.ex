defmodule Mix.Tasks.Test.Journal do
  @moduledoc """
  Custom mix task for running journal entry tests with different configurations.
  
  ## Examples
  
      # Run basic journal entry tests
      mix test.journal
      
      # Run with performance tests
      mix test.journal --performance
      
      # Run integration tests only
      mix test.journal --integration
      
      # Run with coverage
      mix test.journal --cover
  """
  
  use Mix.Task

  @shortdoc "Run journal entry tests"

  def run(args) do
    {options, _remaining_args, _invalid} = OptionParser.parse(args, 
      switches: [
        performance: :boolean,
        integration: :boolean,
        cover: :boolean,
        verbose: :boolean
      ],
      aliases: [
        p: :performance,
        i: :integration,
        c: :cover,
        v: :verbose
      ]
    )

    # Set environment variables for performance tests
    if options[:performance] do
      System.put_env("RUN_PERFORMANCE_TESTS", "1")
      Mix.shell().info("Running with performance tests enabled...")
    end

    # Build test command
    test_command = build_test_command(options)
    
    Mix.shell().info("Executing: #{test_command}")
    
    # Run the tests
    System.cmd("mix", String.split(test_command), into: IO.stream(:stdio, :line))
  end

  defp build_test_command(options) do
    base_command = "test"
    
    # Add coverage if requested
    command = if options[:cover] do
      base_command <> " --cover"
    else
      base_command
    end
    
    # Add specific test files based on options
    command = case {options[:performance], options[:integration]} do
      {true, true} ->
        command <> " test/ex_accounting/journal_entry_test.exs test/ex_accounting/journal_entry_integration_test.exs test/ex_accounting/journal_entry_performance_test.exs"
      
      {true, false} ->
        command <> " test/ex_accounting/journal_entry_test.exs test/ex_accounting/journal_entry_performance_test.exs"
      
      {false, true} ->
        command <> " test/ex_accounting/journal_entry_test.exs test/ex_accounting/journal_entry_integration_test.exs"
      
      {false, false} ->
        command <> " test/ex_accounting/journal_entry_test.exs"
    end
    
    # Add performance tag inclusion/exclusion
    command = if options[:performance] do
      command <> " --include performance"
    else
      command <> " --exclude performance"
    end
    
    # Add verbose flag if requested
    if options[:verbose] do
      command <> " --trace"
    else
      command
    end
  end
end