module Bang
  module Error
    class Base < StandardError
      DEFAULT_CODE = 0

      attr_reader :debug_message

      def initialize(code: nil, message: nil, debug_message: nil)
        super(message)
        @code = code
        @debug_message = debug_message unless Rails.env.production?
      end

      def code
        @code || self.class::DEFAULT_CODE
      end

      def self.convert(exception)
        return exception if exception.is_a? Base
        self.new(debug_message: exception.message)
      end
    end

    class ValidationError < Base
      DEFAULT_CODE = 10003

      def self.convert(exception)
        if exception.is_a? ActiveRecord::RecordInvalid
          self.new(debug_message: 'ActiveRecord::RecordInvalid', message: exception.message)
        else
          self.new(debug_message: exception.message)
        end
      end
    end

    class AuthenticationFailed < Base
    end

    class UserBanned < Base
      DEFAULT_CODE = 20001
    end

    class InvalidUserBang < Base
    end

    class ConversationNotFound < Base
    end

    class ConversationUserNotFound < Base
    end
  end
end
