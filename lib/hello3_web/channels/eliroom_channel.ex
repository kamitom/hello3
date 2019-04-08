defmodule Hello3Web.EliRoomChannel do
  use Phoenix.Channel

  def join("eliroom:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msgA", %{"body" => body}, socket) do
    broadcast!(socket, "new_msgA", %{"body" => body})
    {:noreply, socket}
  end

end
