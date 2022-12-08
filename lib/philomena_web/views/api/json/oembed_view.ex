defmodule PhilomenaWeb.Api.Json.OembedView do
  use PhilomenaWeb, :view

  def render("error.json", _assigns) do
    %{
      error: "Couldn't find an image"
    }
  end

  def render("show.json", %{image: image}) do
    %{
      version: "1.0",
      type: "photo",
      title: "##{image.id} - #{tag_list(image)} - Tantabus",
      author_url: image.source_url || "",
      author_name: artist_tags(image.tags),
      provider_name: "Tantabus",
      provider_url: PhilomenaWeb.Endpoint.url(),
      cache_age: 7200,
      tantabus_id: image.id,
      tantabus_score: image.score,
      tantabus_comments: image.comments_count,
      tantabus_tags: Enum.map(image.tags, & &1.name)
    }
  end

  defp artist_tags(tags) do
    tags
    |> Enum.filter(&(&1.namespace == "artist"))
    |> Enum.map_join(", ", & &1.name_in_namespace)
  end
end
