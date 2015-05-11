module Bang
  class HTTPHeader
    TOKEN = 'X-Bang-Token'
    APP_ID = 'X-Bang-App-Id'
    APP_VERSION = 'X-Bang-App-Version'
    APP_VERSION_CODE = 'X-Bang-App-Version-Code'
    OS = 'X-Bang-Os'
    OS_VERSION = 'X-Bang-Os-Version'
    MODEL = 'X-Bang-Os-Model'
    UUID = 'X-Bang-Os-Uuid'

    attr_accessor :token
    attr_accessor :app_id
    attr_accessor :app_version
    attr_accessor :app_version_ode
    attr_accessor :os
    attr_accessor :os_version
    attr_accessor :model
    attr_accessor :uuid

    def initialize(headers)
      @token = headers[TOKEN]
      @app_id = headers[APP_ID]
      @app_version = headers[APP_VERSION]
      @app_version_ode = headers[APP_VERSION_CODE]
      @os = headers[OS]
      @os_version = headers[OS_VERSION]
      @model = headers[MODEL]
      @uuid = headers[UUID]
    end

    def self.create_from_headers(headers)
      token = headers[TOKEN]
      app_id = headers[APP_ID]
      app_version = headers[APP_VERSION]
      app_version_ode = headers[APP_VERSION_CODE]
      os = headers[OS]
      os_version = headers[OS_VERSION]
      model = headers[MODEL]
      uuid = headers[UUID]
    end

    def to_hash
      {
        TOKEN => @token,
        APP => @app_id,
        APP_VERSION => @app_version,
        APP_VERSION_CODE => @app_version_ode,
        OS => @os,
        OS_VERSION => @os_version,
        MODEL => @model,
        UUID => @uuid,
      }
    end
  end
end
