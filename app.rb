# frozen_string_literal: true

require 'logger'
require 'cgi'
require_relative 'source/router'
require_relative 'source/response_builder'

class App
  def initialize(**options)
    @logger = Logger.new(options[:logdev] || $stdout)
    @router = Router.new
    @response_builder = ResponseBuilder.new
  end

  def call(env)
    @logger.info(env)
    @response_builder.build(body: @router.route!(path(env)).new(params!(env)).format_time!)
  rescue NameError => e
    @response_builder.build(code: 404, body: e.message)
  rescue RegexpError => e
    @response_builder.build(code: 400, body: e.message)
  end

  private

  def path(env)
    env['REQUEST_PATH'].to_sym
  end

  def params!(env)
    params = CGI::parse(env['QUERY_STRING'])['format'][0]
    raise NameError, 'Undefined parameter [format]' if params.nil?

    params.split(',')
  end
end
