# frozen_string_literal: true

require 'cgi'
class TimeService
  FORMAT = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def call(env)
    @env = env
    return [400, { 'Content-Type' => 'text/plain' }, ['unknown params']] if format_params.nil?

    return [400, { 'Content-Type' => 'text/plain' }, [unknown_format_params_string]] if unknown_format_params.length.positive?

    [200, { 'Content-Type' => 'text/plain' }, [result_time_string]]
  end

  private

  def format
    CGI::parse(@env['QUERY_STRING'])['format'][0]
  end

  def format_params
    return nil if format.nil?

    format.split(',')
  end

  def unknown_format_params
    format_params.select { |param| FORMAT[param.to_sym].nil? }
  end

  def unknown_format_params_string
    "Unknown time format [#{unknown_format_params.join(',')}]"
  end

  def result_time_string
    date = Time.now.strftime(format_params.select { |param| (param == 'year') || (param == 'month') || (param == 'day') }
                                   .map { |param| FORMAT[param.to_sym] }.join('-'))
    time = Time.now.strftime(format_params.select { |param| (param == 'hour') || (param == 'minute') || (param == 'second') }
                                     .map { |param| FORMAT[param.to_sym] }.join(':'))
    "#{date}T#{time}"
  end
end
