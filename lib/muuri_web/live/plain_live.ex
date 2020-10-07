defmodule MuuriWeb.PlainLive do
  use MuuriWeb, :child_live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
