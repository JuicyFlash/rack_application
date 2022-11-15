require_relative 'app'

run App.new(logdev: File.expand_path('log/app.log', __dir__))
