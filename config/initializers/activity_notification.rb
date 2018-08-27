ActivityNotification.configure do |config|
  ENV["AN_ORM"] = "active_record" unless ENV["AN_ORM"] == "mongoid"
  config.orm = ENV["AN_ORM"]
  config.enabled = true
  config.notification_table_name = "notifications"
  config.subscription_table_name = "subscriptions"
  config.email_enabled = false
  config.subscription_enabled = false
  config.subscribe_as_default = true
  config.mailer_sender = "please-change-me-at-config-initializers-activity_notification@example.com"
  config.opened_index_limit = 10
end
