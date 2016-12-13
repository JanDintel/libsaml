module Saml
  module Rails
    module ControllerHelper
      def self.included(base)
        base.extend self
        base.before_action :set_response_headers
      end

      def current_provider(entity_id_or_method = nil, &block)
        if block_given?
          before_action &block
        else
          case entity_id_or_method
            when Symbol
              before_action { Saml.current_provider = send(entity_id_or_method) }
            else
              before_action { Saml.current_provider = Saml.provider("#{entity_id_or_method}") }
          end
        end
      end

      def current_store(store)
        before_action { Saml.current_store = store }
      end

      def set_response_headers
        response.headers['Cache-Control'] = 'no-cache, no-store'
        response.headers['Pragma']        = 'no-cache'
      end
    end
  end
end
