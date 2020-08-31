require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AtCoderRivals
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # JavaScriptが無効になっていた場合でも動作するように
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # libディレクトリを読み込む 下は非推奨の書き方
    config.paths.add 'lib', eager_load: true
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.enable_dependency_loading = true
  end
end
