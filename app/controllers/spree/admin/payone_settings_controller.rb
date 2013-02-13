module Spree
  module Admin
    class PayoneSettingsController < BaseController
      def init_preferences
        @connection_preferences = {
          :payone_merchant_id => {},
          :payone_payment_portal_id => {},
          :payone_payment_portal_key => {},
          :payone_sub_account_id => {},
          :payone_test_mode => {}
        }
        
        @redirect_url_preferences = {
          :payone_engine_host => {}
        }
        
        @logging_preferences = {
          :payone_db_logging_enabled => {},
          :payone_file_logging_enabled => {}
        }
        
        @validation_preferences = {
          :payone_billing_address_validation_type => {
            :values => [
              [PayOne::Utils::AddressValidationType::NONE_SYMBOL, PayOne::Utils::AddressValidationType::NONE],
              [PayOne::Utils::AddressValidationType::ADDRESSCHECK_SYMBOL, PayOne::Utils::AddressValidationType::ADDRESSCHECK],
              [PayOne::Utils::AddressValidationType::CONSUMERSCORE_SYMBOL, PayOne::Utils::AddressValidationType::CONSUMERSCORE]]
          },
          :payone_shipping_address_validation_type => {
            :values => [
              [PayOne::Utils::AddressValidationType::NONE_SYMBOL, PayOne::Utils::AddressValidationType::NONE],
              [PayOne::Utils::AddressValidationType::ADDRESSCHECK_SYMBOL, PayOne::Utils::AddressValidationType::ADDRESSCHECK]]
              #[PayOne::Utils::AddressValidationType::CONSUMERSCORE_SYMBOL, PayOne::Utils::AddressValidationType::CONSUMERSCORE]]
          }
        }
        
        @address_validation_preferences = {
          :payone_billing_address_address_check_address_check_type => {
            :values => [
              [PayOne::Utils::AddressCheckType::BASIC_SYMBOL, PayOne::Utils::AddressCheckType::BASIC],
              [PayOne::Utils::AddressCheckType::PERSON_SYMBOL, PayOne::Utils::AddressCheckType::PERSON]]
          },
          :payone_billing_address_consumer_score_address_check_type => {
            :values => [
              [PayOne::Utils::AddressCheckType::BASIC_SYMBOL, PayOne::Utils::AddressCheckType::BASIC],
              [PayOne::Utils::AddressCheckType::PERSON_SYMBOL, PayOne::Utils::AddressCheckType::PERSON],
              [PayOne::Utils::AddressCheckType::NO_SYMBOL, PayOne::Utils::AddressCheckType::NO]]
          },
          :payone_billing_address_consumer_score_consumer_score_type => {
            :values => [
              [PayOne::Utils::ConsumerScoreType::IH_SYMBOL, PayOne::Utils::ConsumerScoreType::IH],
              [PayOne::Utils::ConsumerScoreType::IA_SYMBOL, PayOne::Utils::ConsumerScoreType::IA],
              [PayOne::Utils::ConsumerScoreType::IB_SYMBOL, PayOne::Utils::ConsumerScoreType::IB]]
          },
          :payone_shipping_address_address_check_address_check_type => {
            :values => [
              [PayOne::Utils::AddressCheckType::BASIC_SYMBOL, PayOne::Utils::AddressCheckType::BASIC],
              [PayOne::Utils::AddressCheckType::PERSON_SYMBOL, PayOne::Utils::AddressCheckType::PERSON]]
          },
          :payone_shipping_address_consumer_score_address_check_type => {
            :values => [
              [PayOne::Utils::AddressCheckType::BASIC_SYMBOL, PayOne::Utils::AddressCheckType::BASIC],
              [PayOne::Utils::AddressCheckType::PERSON_SYMBOL, PayOne::Utils::AddressCheckType::PERSON],
              [PayOne::Utils::AddressCheckType::NO_SYMBOL, PayOne::Utils::AddressCheckType::NO]]
          },
          :payone_shipping_address_consumer_score_consumer_score_type => {
            :values => [
              [PayOne::Utils::ConsumerScoreType::IH_SYMBOL, PayOne::Utils::ConsumerScoreType::IH],
              [PayOne::Utils::ConsumerScoreType::IA_SYMBOL, PayOne::Utils::ConsumerScoreType::IA],
              [PayOne::Utils::ConsumerScoreType::IB_SYMBOL, PayOne::Utils::ConsumerScoreType::IB]]
          }
        }
        
        @address_check_validation_preferences = {
          :payone_address_check_none_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_ppb_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_phb_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_pab_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_pki_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_pnz_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_ppv_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          },
          :payone_address_check_ppf_person_status_to_consumer_score_score_mapping => {
            :values => [
              [PayOne::Utils::Score::GREEN_SYMBOL, PayOne::Utils::Score::GREEN],
              [PayOne::Utils::Score::YELLOW_SYMBOL, PayOne::Utils::Score::YELLOW],
              [PayOne::Utils::Score::RED_SYMBOL, PayOne::Utils::Score::RED]]
          }
        }
        
        @consumer_score_validation_preferences = {
          :payone_consumer_score_on_yellow_score_allow_total_under => {},
          :payone_consumer_score_on_yellow_score_block_total_over => {},
          :payone_consumer_score_on_yellow_score_gateway_payone_credit_card_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_online_bank_transfer_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_debit_payment_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_e_wallet_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_cash_on_delivery_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_cash_in_advance_enabled => {},
          :payone_consumer_score_on_yellow_score_payment_method_payone_invoice_enabled => {}
        }
      end
      
      def show
        init_preferences
      end

      def edit
        init_preferences
      end

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        redirect_to admin_payone_settings_path
      end

      def dismiss_alert
        if request.xhr? and params[:alert_id]
          dismissed = Spree::Config[:dismissed_spree_alerts] || ''
          Spree::Config.set :dismissed_spree_alerts => dismissed.split(',').push(params[:alert_id]).join(',')
          filter_dismissed_alerts
          render :nothing => true
        end
      end
    end
  end
end