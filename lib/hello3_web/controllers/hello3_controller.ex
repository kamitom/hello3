defmodule Hello3Web.Hello3Controller do
  use Hello3Web, :controller

  tupleTeat1 = %{tw: "taipei", jp: "tokyo", us: "washington"}

  def index(conn, _params) do
    # render conn, "index.html"
    my_stats = {175, 6.25, "TOM"}
    capitals2 = %{alabama: "Montgomery", alaska: "Juneau", arizona: "Phoenix"}

    conn
    |> put_flash(:error, "Welcome Back!")
    # |> put_resp_content_type("text/plain")
    |> assign(:xx_var, "蜘蛛人：新宇宙")
    |> assign(:balenaApps, capitals2.alaska)
    |> render("index.html")
  end

  def show(conn, %{"msgA" => userName}) do
    render(conn, "show.html", msgA: userName)
  end

  def balenacloudGetTest2 do
    token = "aOiwTIf5gpRcggfBHUwqALGMj3FY8nzq"
    url = "https://api.balena-cloud.com/v4/application"
    headers = [Authorization: "Bearer #{token}", Accept: "Application/json; Charset=utf-8"]
    # options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 500]
    {:ok, response} = HTTPoison.get(url, headers)

    handle_json({:ok, response})
  end

  def handle_json({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_json({_, %{status_code: _, body: body}}) do
    IO.puts("Something went wrong. Please check your internet connection")
  end
end
