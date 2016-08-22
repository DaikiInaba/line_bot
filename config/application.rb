require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LoversBot
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/lib/ext)

    config.generators do |g|
      g.helper false
      g.javascripts false
      g.stylesheets false
      g.test_framework false
    end
  end
end
