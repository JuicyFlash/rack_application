# frozen_string_literal: true

class TimeFormatter
  FORMAT = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def initialize(format_params)
    @format_params = format_params
    @unknown_format_params = @format_params.select { |param| FORMAT[param.to_sym].nil? }
  end

  def format_time!
    raise RegexpError, "Unknown time format [#{@unknown_format_params.join(',')}]" if @unknown_format_params.length.positive?

    "#{date_str} #{time_str}"
  end

  private

  def date_str
    Time.now.strftime(@format_params.select { |param| (param == 'year') || (param == 'month') || (param == 'day') }
                                    .map { |param| FORMAT[param.to_sym] }.join('-'))
  end

  def time_str
    Time.now.strftime(@format_params.select { |param| (param == 'hour') || (param == 'minute') || (param == 'second') }
                                    .map { |param| FORMAT[param.to_sym] }.join(':'))
  end
end
