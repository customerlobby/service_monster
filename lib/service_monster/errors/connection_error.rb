# custom error for connection related failures, like no internet connection
module ServiceMonster
  module Error
    class ConnectionError < StandardError
    end
  end
end