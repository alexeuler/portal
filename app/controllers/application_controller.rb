class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  protected

  def keep_only!(keys, hash)
    hash.keep_if {|key, value| keys.include? key}
  end

  def request_success(context)
    'Ok'
  end

  def request_error(context)
    'Error'
  end


end
