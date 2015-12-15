module ServiceMonster
  class Client
    module Jobs

      def jobs(options = {})
        response = get("jobs", options)
      end

      def job(id, options = {})
        response = get("jobs/#{id}", options)
      end

    end
  end
end