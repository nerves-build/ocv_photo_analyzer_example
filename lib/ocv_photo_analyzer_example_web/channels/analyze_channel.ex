defmodule OcvPhotoAnalyzerExampleWeb.AnalyzeChannel do
  use OcvPhotoAnalyzerExampleWeb, :channel

  def shout do
    Process.send(self(), :shout, [])
  end

  def handle_in("start_load", payload, socket) do
    OcvPhotoAnalyzerExample.Photos.create_histogram(payload)
    |> broadcast_histogram(socket)

    OcvPhotoAnalyzerExample.Photos.find_dominant(payload)[:dominant]
    |> broadcast_dominant_color(socket)

    {:noreply, socket}
  end

  def join("photo_analyzer:live", _payload, socket) do
    {:ok, %{}, socket}
  end

  defp broadcast_histogram(hst, socket) do
    broadcast!(socket, "refresh", histogram_format(hst))
  end

  defp broadcast_dominant_color(color_list, socket) do
    broadcast!(socket, "refresh", dominant_color_format(color_list))
  end

  defp histogram_format(hst) do
    %{
      histogram: hst.histogram
    }
  end

  defp dominant_color_format(color_list) do
    %{
      dominant:
        Enum.map(color_list, fn c ->
          %{
            r: c.r,
            g: c.g,
            b: c.b
          }
        end)
    }
  end
end
