defmodule BalanceSheet.AccountView do
  use BalanceSheet.Web, :view

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, BalanceSheet.AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, BalanceSheet.AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      id: account.id,
      name: account.name,
      description: account.description}
  end
end
