# frozen_string_literal: true

# Controller for the application status, useful for debugging
class HealthController < ActionController::Base
  respond_to :json

  def status
    require 'version'

    render json: {
      name: 'Fab-manager',
      status: 'running',
      dependencies: {
        postgresql: HealthService.database?,
        redis: HealthService.redis?,
        elasticsearch: HealthService.elasticsearch?
      },
      up_to_date: {
        migrations: HealthService.migrations?,
        version: Version.up_to_date?
      },
      stats: HealthService.stats,
      tagline: 'The platform to manage your fablab or your coworking space.'
    }
  end
end
