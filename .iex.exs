defmodule Dev do
  def update_widget_type(widget_id, type) do
    Phoenix.PubSub.broadcast!(
      Muuri.PubSub,
      "widgets:#{widget_id}",
      {[:widget, :updated], %{id: widget_id, type: type}}
    )
  end
end
