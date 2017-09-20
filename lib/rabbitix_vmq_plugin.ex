defmodule RabbitixVmqPlugin do
    use Application
  
    def start(_type, _args) do
      IO.puts "*** plugin started"
      RabbitixVmqPlugin.Supervisor.start_link()
    end
  
    def auth_on_register(_peer, {_mountpoint, clientid}, _username, _pw, _clean_session) do
      IO.puts "*** auth_on_register #{clientid}"
      {:ok, []}
    end
  
    def auth_on_subscribe(_username, {_mountpoint, clientid}, topics) do
      IO.puts "*** auth_on_subscribe #{clientid}"
      {:ok, topics}
    end
  
    def auth_on_publish(_username, {_mountpoint, clientid}, _qos, topic, payload, _flag) do
      IO.puts "*** auth_on_publish #{clientid} / #{topic} / #{payload}"
      {:ok, payload}
    end
  
    def on_publish(_username, {_mountpoint, clientid}, _qos, topic, payload, _is_retain) do
      IO.puts "*** on_publish #{clientid} / #{topic} / #{payload}"
      :ok
    end
  
    def on_deliver(_username, {_mountpoint, clientid}, topic, payload) do
      IO.puts "*** on_deliver #{clientid} / #{topic} / #{payload}"
      :ok
    end
  
    def on_offline_message({_mountpoint, clientid}, _qos, topic, payload, _is_retain) do
      IO.puts "*** on_offline_message #{clientid} / #{topic} / #{payload}"
      :ok
    end
  end