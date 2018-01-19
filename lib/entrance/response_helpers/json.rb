require_relative 'statuses'

module Entrance
  module ResponseHelpers
    module JSON
      def json_render(payload, status)
        render json: payload, status: status
      end

      def json_error!(payload, status = ::Entrance::ResponseHelpers::Statuses::ERROR)
        json_render payload, status
      end

      def json_success!(payload, status = ::Entrance::ResponseHelpers::Statuses::SUCCESS)
        json_render payload, status
      end

      def json_created!(payload, status = ::Entrance::ResponseHelpers::Statuses::CREATED)
        json_render payload, status
      end
    end
  end
end