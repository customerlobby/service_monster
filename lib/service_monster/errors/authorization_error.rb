# custom error for authorization related failures
module ServiceMonster
  module Error
    class AuthorizationError < StandardError
    end
  end
end