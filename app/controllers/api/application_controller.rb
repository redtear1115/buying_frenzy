class Api::ApplicationController < ApplicationController
  before_action :daterange

  private

  def error_response(error_message)
    render status: 400, json: { error_message: error_message }
  end

  def ok_response(data)
    render json: { data: data }
  end

  def daterange
    @daterange = Time.parse(params[:from]).beginning_of_day .. Time.parse(params[:to]).end_of_day
  rescue
    @daterange = 1.month.ago.all_month
  end
end
