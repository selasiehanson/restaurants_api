module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
      @json = @json.symbolize_keys
    end
  end
end
