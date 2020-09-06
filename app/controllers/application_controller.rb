class ApplicationController < ActionController::API
    # custom exception
    Forbidden = Class.new(StandardError)
    rescue_from ActiveRecord::RecordInvalid, with: :unvalid_record
    rescue_from Forbidden, with: :forbidden


    private
      def unvalid_record(e)
        render json: {errors: e.record.errors} , status: :unprocessable_entity
      end

      def forbidden
        render json: {} , status: :forbidden
      end

      def check_amount(amount)
          check = Float(amount) rescue nil
          if !check
            render json: {errors: "invalid params amount"}, status: :unprocessable_entity
          end
      end
end
