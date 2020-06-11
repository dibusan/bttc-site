require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsDevise
  class Application < Rails::Application
    Spring.watch "app/services/**"

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    am_8 = DateTime.now.beginning_of_day + 8.hours
    pm_8 = DateTime.now.beginning_of_day + 20.hours

    config.club_hours = {
      monday: { start: am_8, end: pm_8 },
      tuesday: { start: am_8, end: pm_8 },
      wednesday: { start: am_8, end: pm_8 },
      thursday: { start: am_8, end: pm_8 },
      friday: { start: am_8, end: pm_8 },
      saturday: { start: am_8, end: pm_8 },
      sunday: { start: am_8, end: pm_8 }
    }

    config.club_table_reserve_duration = 2.hours
    config.club_max_availability = 24
    config.time_zone = 'Eastern Time (US & Canada)'
  end
end
