defmodule Provider do
  @moduledoc """
  Handles the requests against the ranking provider
  """
  @endpoint "https://api.coinmarketcap.com/v2/ticker/?sort=rank"

  @doc """
  Makes a request to the provider endpoint to retrieve the current
  ranking of the top 100 coins
  """
  @spec get_ranking :: {:ok, map()} | {:error, binary()}
  def get_ranking do
    with {:ok, body} <- make_request(),
         {:ok, decoded_response} <- Jason.decode(body) do
      check_response_body(decoded_response)
    end
  end

  @spec make_request :: {:ok, String.t()} | {:error, any()}
  defp make_request do
    case HTTPoison.get(@endpoint) do
      {:ok, response} ->
        {:ok, response.body}

      error ->
        error
    end
  end

  @spec check_response_body(map()) :: {:ok, map()} | {:error, String.t()}
  defp check_response_body(%{"metadata" => %{"error" => nil}} = body) do
    {:ok, body}
  end

  defp check_response_body(%{"metadata" => %{"error" => reason}}) do
    {:error, reason}
  end
end
