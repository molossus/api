defmodule BalanceSheet.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def up do
    # Enable the UUID Extension for Primary Keys
    execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")

    # Create the PG Enumeration for AccountType
    execute("CREATE TYPE account_type AS ENUM ('checking', 'savings', 'retirement')")

    # Create the actual accounts table
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text

      add :type, :account_type

      timestamps()
    end
  end

  def down do
    execute("DROP TYPE account_type")
    execute("DROP EXTENSION \"uuid-ossp\"")
    drop table(:accounts)
  end
end
