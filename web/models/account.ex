defmodule BalanceSheet.Account do
  use BalanceSheet.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "accounts" do
    field :name, :string
    field :description, :string
    field :type, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:id, :name, :description])
    |> validate_required([:id, :name, :description])
  end
end
