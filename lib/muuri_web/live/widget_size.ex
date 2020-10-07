defmodule MuuriWeb.WidgetSize do
  def width(%{type: type}) do
    case type do
      "Plain" -> "w-full sm:w-1/2 lg:w-1/4"
      "Map" -> "w-full lg:w-1/2"
    end
  end
end
