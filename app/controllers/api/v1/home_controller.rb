class Api::V1::HomeController < Api::ApplicationController
  def top_users
    number = params[:number].to_i
    error_response('please enter number more than 0') && return unless number > 0
    ok_response(PurchaseHistory.top_users(@daterange, number))
  end

  def most_popular
    error_response('not allow mode') && return unless ['count', 'amount'].include? params[:mode]
    ok_response(PurchaseHistory.most_popular(params[:mode]))
  end

  def user_count
    amount = params[:amount].to_i
    error_response('please enter amount more than 0') && return unless amount > 0
    error_response('not allow mode') && return unless ['above', 'below'].include? params[:mode]
    ok_response(PurchaseHistory.user_count(@daterange, params[:mode], amount))
  end

  def summary
    ok_response(PurchaseHistory.summary(@daterange))
  end
end
