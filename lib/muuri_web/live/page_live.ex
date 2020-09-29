defmodule MuuriWeb.PageLive do
  use MuuriWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, cards: [3, 2, 1], next_card: 4), temporary_assigns: [cards: []]}
  end

  @impl true
  def handle_event("add", _params, socket) do
    %{next_card: next_card} = socket.assigns
    {:noreply, assign(socket, cards: [next_card], next_card: next_card + 1)}
  end
end
