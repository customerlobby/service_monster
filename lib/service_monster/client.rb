module ServiceMonster
  # Wrapper for the ServiceMonster REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}
    
    include ServiceMonster::Client::Accounts
    include ServiceMonster::Client::ApiRequests
    include ServiceMonster::Client::Orders
    include ServiceMonster::Client::Jobs
    include ServiceMonster::Client::Reminders
  end
end