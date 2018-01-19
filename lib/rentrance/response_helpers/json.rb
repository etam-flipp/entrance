require_relative 'statuses'

module Rentrance
  module ResponseHelpers
    module JSON
      def json_render(payload, status)
        render json: payload, status: status
      end

      def json_error!(payload, status = ::Rentrance::ResponseHelpers::Statuses::ERROR)
        json_render payload, status
      end

      def json_success!(payload, status = ::Rentrance::ResponseHelpers::Statuses::SUCCESS)
        json_render payload, status
      end

      def json_created!(payload, status = ::Rentrance::ResponseHelpers::Statuses::CREATED)
        json_render payload, status
      end
    end
  end
end