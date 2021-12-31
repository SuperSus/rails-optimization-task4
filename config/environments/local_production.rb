# rubocop:disable Metrics/BlockLength
#
def yarn_integrity_enabled?
  ENV.fetch("YARN_INTEGRITY_ENABLED", "true") == "true"
end

Rails.application.configure do
  # Verifies that versions and hashed value of the package contents in the project's package.json
  config.webpacker.check_yarn_integrity = yarn_integrity_enabled?

  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = true
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true
  config.cache_store = :memory_store
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=172800"
  }

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  config.assets.compile = true
  config.assets.debug = false
  config.assets.digest = true


  # Supress logger output for asset requests.
  config.assets.quiet = true

  config.action_mailer.perform_caching = false

  config.app_domain = "localhost:3000"

  config.action_mailer.default_url_options = { host: "localhost:3000" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: config.app_domain }
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: "587",
    enable_starttls_auto: true,
    user_name: '<%= ENV["DEVELOPMENT_EMAIL_USERNAME"] %>',
    password: '<%= ENV["DEVELOPMENT_EMAIL_PASSWORD"] %>',
    authentication: :plain,
    domain: "localhost:3000"
  }

  config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.public_file_server.enabled = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Install the Timber.io logger
  send_logs_to_timber = ENV["SEND_LOGS_TO_TIMBER"] || "false" # <---- set to false to stop sending dev logs to Timber.io
  log_device = send_logs_to_timber == "true" ? Timber::LogDevices::HTTP.new(ENV["TIMBER"]) : STDOUT
  logger = Timber::Logger.new(log_device)
  logger.level = config.log_level
  config.logger = ActiveSupport::TaggedLogging.new(logger)
end

# rubocop:enable Metrics/BlockLength