defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl
  # @moduledoc """
  #   In memory repository
  # """
  # def all(Rumbl.User) do
  #   [%Rumbl.User{id: "1", name: "Yuki Kato", username: "Yukitora", password: "yuki123"},
  #    %Rumbl.User{id: "2", name: "Violet Evergarden", username: "Violeto", password: "violet123"},
  #    %Rumbl.User{id: "3", name: "Chou Tzuyu", username: "Tzuyu", password: "tzuyu123"}]
  # end
  # def all(_module), do: []

  # def get(module, id) do
  #   Enum.find all(module), fn map -> map.id == id end
  # end

  # def get_by(module, params) do
  #   Enum.find all(module), fn map ->
  #     Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
  #   end
  # end
end