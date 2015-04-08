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
    end

    class AuthenticationFaild < Base
    end
  end
end
