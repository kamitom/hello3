defmodule Hello3Web.ElihereController do
  use Hello3Web, :controller

  def world(conn, _params) do
    payload100 = get_smoothies_url()
    payload100 = balenacloudGetTest2()

    conn
    |> assign(:smoothie, payload100)
    # |> assign(:smoothie, Poison.decode!(~S'{"name":"Joe", "id": "13", "version": 0}'))
    |> render("balenacloud.html")

    # render(conn, "world.html")
  end

  def balenacloudGetTest2() do
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

  def get_smoothies_url() do
    case HTTPoison.get(
           "https://www.allrecipes.com/recipes/138/drinks/smoothies/?internalSource=hubcard&referringContentType=Search&clickId=cardslot%201"
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        urls =
          body
          |> Floki.find("a.fixed-recipe-card__title-link")
          |> Floki.attribute("href")

        {:ok, urls}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
