module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
      # @json = @json.symbolize_keys if @json.is_a?(Hash)
      # @json
    end
  end
end
