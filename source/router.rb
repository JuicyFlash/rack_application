# frozen_string_literal: true

require_relative 'time_formatter'

class Router

  ROUTES = { '/time': TimeFormatter }.freeze

  def route!(path)
    raise NameError, "Unknown route for [#{path.to_sym}]" if ROUTES[path.to_sym].nil?

    ROUTES[path.to_sym]
  end
end
