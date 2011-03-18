require "yaml"
require "erb"

module ASIN
  class Configuration
    class << self

      attr_accessor :secret, :key, :host, :logger

      # Rails initializer configuration.
      # 
      # Expects at least +secret+ and +key+ for the API call:
      # 
      #   ASIN::Configuration.configure do |config|
      #     config.secret = 'your-secret'
      #     config.key = 'your-key'
      #   end
      #
      # You may pass options as a hash as well:
      #
      #   ASIN::Configuration.configure :secret => 'your-secret', :key => 'your-key'
      #
      # Or configure everything using YAML:
      #
      #   ASIN::Configuration.configure :yaml => 'config/asin.yml'
      # 
      # ==== Options:
      # 
      # [secret] the API secret key
      # [key] the API access key
      # [host] the host, which defaults to 'webservices.amazon.com'
      # [logger] a different logger than logging to STDERR (nil for no logging)
      # 
      def configure(options={})
        init_config
        if block_given?
          yield self
        else
          options.each do |key, value|
            send(:"#{key}=", value)
          end
        end
        self
      end
      
      # Resets configuration to defaults
      #
      def reset
        init_config(true)
      end

      private
      
      # these are the keys that are commonly used in AWS .yml files that we need
      S3_CREDENTIAL_KEYS = [:access_key_id, :secret_access_key]
      # our names for these keys
      alias_method :secret_access_key=, :secret=
      alias_method :access_key_id=, :key=
      
      def s3_credentials=(value)
        load_credentials(value).each do |key, value|
          send(:"#{key}=", value) if S3_CREDENTIAL_KEYS.include? key.to_sym
        end
      end
        
      def load_credentials(value)
        case value
        when File
          YAML::load(ERB.new(File.read(value.path)).result)
        when String, Pathname
          YAML::load(ERB.new(File.read(value)).result)
        when Hash
          value
        else
          raise ArgumentError, "Credentials are not a path, file, or hash."
        end
      end

      def init_config(force=false)
        return if @init && !force
        @init   = true
        @secret = ''
        @key    = ''
        @host   = 'webservices.amazon.com'
        @logger = Logger.new(STDERR)
      end
    end
  end
end

