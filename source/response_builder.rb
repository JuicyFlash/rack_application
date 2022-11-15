# frozen_string_literal: true

class ResponseBuilder
  def build(params = {})
    [
      params[:code] ||= 200,
      { 'Content-Type' => 'text/plain' },
      [params[:body]]
    ]
  end
end
