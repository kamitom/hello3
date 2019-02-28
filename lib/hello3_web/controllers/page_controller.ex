defmodule Hello3Web.PageController do
  use Hello3Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
