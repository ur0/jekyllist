module Jekyllist
  module Config
    # Config variables here are mixed in into the Jekyllist module
    def client_id
      # GitHub client id
      ENV['client_id'] || '0b496840e5562f9f6d22'
    end

    def client_secret
      ENV['client_secret'] || 'ce1d0051e2a491710c9c0eb321903f78a90da102'
    end

    def scope
      'user:email,repo'
    end
  end
end