# frozen_string_literal: true

require_relative 'time_service'

class Router

  ROUTES = { '/time': TimeService }.freeze

  def call(env)
    if check_path(env).nil?
      [
        404,
        { 'Content-Type' => 'text/plain' },
        ['Bad getaway']
      ]
    else
      check_path(env).new.call(env)
    end
  end

  private

  def check_path(env)
    ROUTES[env['REQUEST_PATH'].to_sym]
  end
end
