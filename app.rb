# frozen_string_literal: true

require 'logger'
require_relative 'source/router'

class App
  def initialize(**options)
    @logger = Logger.new(options[:logdev] || $stdout)
    @router = Router.new
  end

  def call(env)
    @logger.info(env)
    @router.call(env)
  end
end
