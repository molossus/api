defmodule BalanceSheet.AccountController do
  use BalanceSheet.Web, :controller

  alias BalanceSheet.Account

  def index(conn, _params) do
    accounts = Repo.all(Account)
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case Repo.insert(changeset) do
      {:ok, account} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", account_path(conn, :show, account))
        |> render("show.json", account: account)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BalanceSheet.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account, account_params)

    case Repo.update(changeset) do
      {:ok, account} ->
        render(conn, "show.json", account: account)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BalanceSheet.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(account)

    send_resp(conn, :no_content, "")
  end
end
