defmodule BalanceSheet.PageController do
  use BalanceSheet.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
