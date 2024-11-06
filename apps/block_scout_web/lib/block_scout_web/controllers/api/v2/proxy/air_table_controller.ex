defmodule BlockScoutWeb.API.V2.Proxy.AirTableController do
  use BlockScoutWeb, :controller

  alias Explorer.ThirdPartyIntegrations.AirTable

  action_fallback(BlockScoutWeb.API.V2.FallbackController)

  @doc """
    Function to handle GET requests to `/api/v2/proxy/airtable/:base_id/:table_id_or_name` endpoint.
  """
  @spec get_multiple(Plug.Conn.t(), map()) :: Plug.Conn.t() | {atom(), any()}
  def get_multiple(conn, %{"base_id" => base_id, "table_id_or_name" => table_id_or_name}) do
    url = AirTable.table_url(base_id, table_id_or_name)

    with {response, status} <- AirTable.api_request(url, conn, :get),
         {:is_empty_response, false} <- {:is_empty_response, is_nil(response)} do
      conn
      |> put_status(status)
      |> json(response)
    end
  end

  @doc """
    Function to handle GET requests to `/api/v2/proxy/airtable/:base_id/:table_id_or_name/:record_id` endpoint.
  """
  @spec get(Plug.Conn.t(), map()) :: Plug.Conn.t() | {atom(), any()}
  def get(conn, %{"base_id" => base_id, "table_id_or_name" => table_id_or_name, "record_id" => record_id}) do
    url = AirTable.record_url(base_id, table_id_or_name, record_id)

    with {response, status} <- AirTable.api_request(url, conn, :get),
         {:is_empty_response, false} <- {:is_empty_response, is_nil(response)} do
      conn
      |> put_status(status)
      |> json(response)
    end
  end

  @doc """
    Function to handle PUT requests to `/api/v2/proxy/airtable/:base_id/:table_id_or_name/:record_id` endpoint.
  """
  @spec put(Plug.Conn.t(), map()) :: Plug.Conn.t() | {atom(), any()}
  def put(conn, %{"base_id" => base_id, "table_id_or_name" => table_id_or_name, "record_id" => record_id}) do
    url = AirTable.record_url(base_id, table_id_or_name, record_id)

    with {response, status} <- AirTable.api_request(url, conn, :put),
         {:is_empty_response, false} <- {:is_empty_response, is_nil(response)} do
      conn
      |> put_status(status)
      |> json(response)
    end
  end

  @doc """
    Function to handle PATCH requests to `/api/v2/proxy/airtable/:base_id/:table_id_or_name/:record_id` endpoint.
  """
  @spec patch(Plug.Conn.t(), map()) :: Plug.Conn.t() | {atom(), any()}
  def patch(conn, %{"base_id" => base_id, "table_id_or_name" => table_id_or_name, "record_id" => record_id}) do
    url = AirTable.record_url(base_id, table_id_or_name, record_id)

    with {response, status} <- AirTable.api_request(url, conn, :patch),
         {:is_empty_response, false} <- {:is_empty_response, is_nil(response)} do
      conn
      |> put_status(status)
      |> json(response)
    end
  end

  @doc """
    Function to handle POST requests to `/api/v2/proxy/airtable/:base_id/:table_id_or_name` endpoint.
  """
  @spec post(Plug.Conn.t(), map()) :: Plug.Conn.t() | {atom(), any()}
  def post(conn, %{"base_id" => base_id, "table_id_or_name" => table_id_or_name}) do
    url = AirTable.table_url(base_id, table_id_or_name)

    with {response, status} <- AirTable.api_request(url, conn, :post),
         {:is_empty_response, false} <- {:is_empty_response, is_nil(response)} do
      conn
      |> put_status(status)
      |> json(response)
    end
  end
end
