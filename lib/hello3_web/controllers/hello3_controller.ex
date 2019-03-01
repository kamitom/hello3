defmodule Hello3Web.Hello3Controller do
  use Hello3Web, :controller
  def index(conn, _params) do
    render conn, "index.html"
  end
end
