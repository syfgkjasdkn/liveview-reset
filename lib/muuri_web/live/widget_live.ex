defmodule MuuriWeb.WidgetLive do
  use MuuriWeb, :child_live_view

  @impl true
  def mount(params, %{"widget_id" => widget_id} = session, socket) do
    if connected?(socket) do
      :ok = Phoenix.PubSub.subscribe(Muuri.PubSub, "widgets:#{widget_id}")
    end

    widget = fetch_widget_from_parent_assigns(socket, widget_id)
    live_view_mod = live_view_mod(widget)
    socket = assign(socket, id: widget.id, widget: widget, live_view_mod: live_view_mod)
    live_view_mod.mount(params, session, socket)
  end

  @impl true
  def render(assigns) do
    live_view_mod(assigns).render(assigns)
  end

  @impl true
  def handle_info({[:widget, :updated], widget}, socket) do
    live_view_mod = live_view_mod(widget)
    socket = assign(socket, widget: widget, live_view_mod: live_view_mod)
    # TODO test there are no suprises
    {:ok, socket} = live_view_mod.mount(:not_mounted_at_router, nil, socket)
    {:noreply, socket}
  end

  defp fetch_widget_from_parent_assigns(socket, widget_id) do
    %{assigns: %{widgets: widgets}} = assign_new(socket, :widgets, fn -> nil end)

    if widgets do
      Enum.find(widgets, fn widget -> widget.id == widget_id end)
    else
      # TODO
      # IO.inspect(Map.from_struct(socket), label: "socket")
      %{id: widget_id, type: "Map"}
    end
  end

  defp live_view_mod(%{type: type}) do
    case type do
      "Map" -> MuuriWeb.MapLive
      "Plain" -> MuuriWeb.PlainLive
    end
  end

  defp live_view_mod(%{assigns: assigns}) do
    live_view_mod(assigns)
  end

  defp live_view_mod(%{live_view_mod: live_view_mod}) do
    live_view_mod
  end
end
