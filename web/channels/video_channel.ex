defmodule Rumbl.VideoChannel do
    use Rumbl.Web, :channel
    alias Rumbl.AnnotationView

    def join("videos:" <> video_id, _params, socket) do
        video_id = String.to_integer(video_id)
        video = Repo.get!(Rumbl.Video, video_id)

        annotations = Repo.all(
            from a in assoc(video, :annotations),
                order_by: [asc: a.at, asc: a.id],
                limit: 200,
                preload: [:user]
        )

        resp = %{annotations: Phoenix.View.render_many(annotations, AnnotationView, "annotation.json")}
        {:ok, resp, assign(socket, :video_id, video_id)}
    end

    def handle_in(event, params, socket) do
        user = Repo.get(Rumbl.User, socket.assigns.user_id)
        handle_in(event, params, user, socket)
    end
    def handle_in("new annotation", params, user, socket) do
        changeset =
            user
            |> build_assoc(:annotations, video_id: socket.assigns.video_id)
            |> Rumbl.Annotation.changeset(params)
        
        case Repo.insert(changeset) do
            {:ok, annotation} ->
                broadcast! socket, "new annotation", %{
                    id: annotation.id,
                    user: Rumbl.UserView.render("user.json", %{user: user}),
                    body: params["body"],
                    at: params["at"]
                }
                {:reply, :ok, socket}
            {:error, changeset} ->
                {:reply, {:error, %{errors: changeset}}, socket}
        end
    end
end