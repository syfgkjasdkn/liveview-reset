defmodule MuuriWeb.PageLive do
  use MuuriWeb, :live_view
  import MuuriWeb.WidgetSize

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, widgets: [%{type: "Plain", id: "1"}, %{type: "Map", id: "2"}])}
  end
end
