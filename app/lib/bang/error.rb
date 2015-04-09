module Bang
  module Error
    class Base < StandardError
      DEFAULT_CODE = 0

      def initialize(code: nil, message: nil)
        super(message)
        @code = code
      end

      def code
        @code || self.class::DEFAULT_CODE
      end

      def self.convert(exception)
        return exception if exception.is_a? Base
        self.new(debug_message: exception.message)
      end
    end

    class AuthenticationFaild < Base
    end

    class ValidationError < Base
      DEFAULT_CODE = 10003

      def self.convert(exception)
        if exception.is_a? ActiveRecord::RecordInvalid
          self.new(debug_message: 'ActiveRecord::RecordInvalid', message: exception.message, errors: [exception.message])
        else
          self.new(debug_message: exception.message)
        end
      end
    end
  end
end
