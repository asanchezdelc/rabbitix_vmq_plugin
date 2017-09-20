defmodule RabbitixVmqPlugin.Mixfile do
  use Mix.Project

  def project do
    [app: :theo_verne_plugin,
     version: "0.1.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  defp vmq_plugin_hooks do
    hooks = [
      {RabbitixVmqPlugin, :auth_on_register, 5, []},
      {RabbitixVmqPlugin, :auth_on_subscribe, 3, []},
      {RabbitixVmqPlugin, :auth_on_publish, 6, []},
      {RabbitixVmqPlugin, :on_publish, 6, []},
      {RabbitixVmqPlugin, :on_deliver, 4, []},
      {RabbitixVmqPlugin, :on_offline_message, 5, []}
    ]
    {:vmq_plugin_hooks, hooks}
  end

  def application do
    [
      mod: {RabbitixVmqPlugin, []},
      extra_applications: [:logger],
      env: [vmq_plugin_hooks()]
    ]
  end

  defp deps do
    [{:distillery, "~> 1.4", runtime: false}]
  end
end