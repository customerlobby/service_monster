# frozen_string_literal: true

module ServiceMonster
  module Response
    def self.create(response_hash)
      data = begin
               response_hash.data.dup
             rescue StandardError
               response_hash
             end
      data.extend(self)
      data
    end

    def self.create_empty
      data = { count: 0, items: [] }
      data.extend(self)
      data
    end

    attr_reader :pagination
    attr_reader :meta
  end
end
