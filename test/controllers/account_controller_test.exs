defmodule BalanceSheet.AccountControllerTest do
  use BalanceSheet.ConnCase

  alias BalanceSheet.Account
  @valid_attrs %{description: "some content", id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, account_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    account = Repo.insert! %Account{}
    conn = get conn, account_path(conn, :show, account)
    assert json_response(conn, 200)["data"] == %{"id" => account.id,
      "id" => account.id,
      "name" => account.name,
      "description" => account.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, account_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, account_path(conn, :create), account: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Account, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, account_path(conn, :create), account: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    account = Repo.insert! %Account{}
    conn = put conn, account_path(conn, :update, account), account: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Account, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    account = Repo.insert! %Account{}
    conn = put conn, account_path(conn, :update, account), account: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    account = Repo.insert! %Account{}
    conn = delete conn, account_path(conn, :delete, account)
    assert response(conn, 204)
    refute Repo.get(Account, account.id)
  end
end
