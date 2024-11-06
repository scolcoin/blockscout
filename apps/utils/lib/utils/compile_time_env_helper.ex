defmodule Utils.CompileTimeEnvHelper do
  @moduledoc """
  A module that helps with compile-time environment variable handling and automatic
  module recompilation when environment variables change.

  ## Usage
      use Utils.CompileTimeEnvHelper,
        attribute_name: [:app, :test],
        attribute_name1: [:app, [:nested, :key]]

      def test do
        @test
      end
  """

  defmacro __using__(env_vars) do
    Utils.CompileTimeEnvHelper.__generate_attributes_and_recompile_functions__(env_vars)
  end

  def __generate_attributes_and_recompile_functions__(env_vars) do
    quote do
      Module.register_attribute(__MODULE__, :__compile_time_env_vars, accumulate: true)

      for {attribute_name, [app, key_or_path]} <- unquote(env_vars) do
        Module.put_attribute(
          __MODULE__,
          attribute_name,
          Application.compile_env(app, key_or_path)
        )

        Module.put_attribute(
          __MODULE__,
          :__compile_time_env_vars,
          {Application.compile_env(app, key_or_path), {app, key_or_path}}
        )
      end

      def __mix_recompile__? do
        @__compile_time_env_vars
        |> Enum.map(fn
          {value, {app, [key | path]}} -> value != get_in(Application.get_env(app, key), path)
          {value, {app, key}} -> value != Application.get_env(app, key)
        end)
        |> Enum.any?()
      end
    end
  end
end
