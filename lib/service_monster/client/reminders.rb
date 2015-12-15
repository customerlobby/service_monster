module ServiceMonster
  class Client
    module Reminders

      def reminders(options = {})
        response = get("reminders", options)
      end

      def reminder(id, options = {})
        response = get("reminders/#{id}", options)
      end

    end
  end
end