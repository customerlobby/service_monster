require File.expand_path('errors/connection_error', __dir__)
require File.expand_path('errors/authorization_error', __dir__)

module ServiceMonster
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options)
      begin
        response = connection.send(method) do |request|
          case method
          when :get
            formatted_options = format_options(options)
            request.url(path, formatted_options)
          when :post, :put
            request.headers['Content-Type'] = 'application/json'
            request.body = options.to_json unless options.empty?
            request.url(path)
          end
        end
      rescue StandardError
        # handle connection related failures and raise gem specific standard error
        raise ServiceMonster::Error::ConnectionError.new, 'Connection failed.'
      end

      # check if the status code is 401
      if response.status == 200
        Response.create(response.body)
      elsif response.status == 401
        raise ServiceMonster::Error::AuthorizationError.new, 'Invalid credentials.'
      elsif response.status == 500 && response.body.exceptionMessage.present? && response.body.exceptionMessage =~ /Sequence contains no elements/
        Response.create_empty
      elsif response.status == 504
        raise ServiceMonster::Error::ConnectionError.new, 'Connection failed.'
      else
        raise StandardError.new, "Failed to fetch data from ServiceMonster, status code: #{response.status}"
      end
    end

    # Format the Options before you send them off to ServiceMonster
    def format_options(options)
      return if options.blank?
      options[:fields]     = format_fields(options[:fields]) if options.key?(:fields)
      options[:limit]      = options[:limit] if options.key?(:limit)
      options[:pageindex]  = options[:page]  if options.key?(:page)
      options[:q]          = options[:q] if options.key?(:q)
      options[:wField]     = options[:wField] if options.key?(:wField)
      options[:wOperator]  = options[:wOperator] if options.key?(:wOperator)
      options[:wValue]     = options[:wValue] if options.key?(:wValue)

      options
    end

    # format the fields to a format that the ServiceMonster likes
    # @param [Array or String] fields can be specified as an Array or String
    # @return String
    def format_fields(fields)
      if fields.instance_of?(Array)
        fields.join(',')
      elsif fields.instance_of?(String)
        fields
      end
    end
  end
end
