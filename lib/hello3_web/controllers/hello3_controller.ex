defmodule Hello3Web.Hello3Controller do
  use Hello3Web, :controller

  def index(conn, _params) do
    # render conn, "index.html"
    conn
    |> put_flash(:error, "Welcome Back!")
    # |> put_resp_content_type("text/plain")
    |> assign(:xx_var, "蜘蛛人：新宇宙")
    |> render("index.html")
  end

  def show(conn, %{"msgA" => userName}) do
    render(conn, "show.html", msgA: userName)
  end

end
