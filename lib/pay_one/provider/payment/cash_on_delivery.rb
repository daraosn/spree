##
# CashOnDelivery class
# 
# Class provides Spree payment method actions (authorize, capture, purchcase, debit, void).
##
module PayOne
  module Provider
    module Payment
      class CashOnDelivery < PayOne::Provider::Payment::Base
      
        # Sets initial data.
        def initialize(options)
          super(options)
          @shipping_provider = options[:shipping_provider]
        end
        
        # Proceses payment method authorize action.
        def authorize(money, cash_on_delivery_source, payment_method_options = {})
          PayOne::Logger.info "Authorize process started"
          
          request = PayOne::Proxy::Request.new
          request.preauthorization_request
          
          set_initial_request_parameters(request)
          set_cash_on_delivery_request_parameters(request, cash_on_delivery_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway purchase action.
        def purchase(money, cash_on_delivery_source, payment_method_options = {})
          PayOne::Logger.info "Purchase process started"
          
          request = PayOne::Proxy::Request.new
          request.authorization_request
          
          set_initial_request_parameters(request)
          set_cash_on_delivery_request_parameters(request, cash_on_delivery_source)
          set_amount_request_parameters(request, money, payment_method_options)
          set_order_request_parameters(request, payment_method_options)
          set_personal_data_request_parameters(request, payment_method_options)
          set_billing_request_parameters(request, payment_method_options)
          set_shipping_request_parameters(request, payment_method_options)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway capture action.
        def capture(money, response_code, payment_method_options = {})
          PayOne::Logger.info "Capture process started"
          
          request = PayOne::Proxy::Request.new
          request.capture_request
          
          set_initial_request_parameters(request)
          set_amount_request_parameters(request, money, payment_method_options)
          set_payment_process_parameters(request, response_code)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Proceses gateway void action.
        def void(response_code, provider_source, gateway_options = {})
          PayOne::Logger.info "Void process started"
          payment_payment_provider_successful_response
        end
        
        # Proceses gateway credit action.
        def credit(money, response_code, gateway_options = {})
          PayOne::Logger.info "Credit process started"
          
          request = PayOne::Proxy::Request.new
          request.debit_request
          set_initial_request_parameters(request)
          set_amount_request_parameters(request, '-' + money.to_s, gateway_options)
          set_payment_process_parameters(request, response_code)
          set_sequence_request_parameters(request, response_code)
          
          response = process_request request, payment_method_options
          payment_provider_response response
        end
        
        # Sets cash on delivery parameters.
        def set_cash_on_delivery_request_parameters(request, cash_on_delivery_source)
          request.cash_on_delivery_clearingtype
          request.shippingprovider= shipping_provider()
        end
        
        # Returns cash on delivery type.
        def shipping_provider()
          type = PayOne::Utils::ShippingProvider.validate(@shipping_provider)
          if type != nil
            return type
          else
            return ''
          end
        end
      end
    end
  end
end