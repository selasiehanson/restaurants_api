class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def error(model)
    res = {}
    unless model.valid? 
      res[:error] = 'Some validation errors have been encountered'
      res[:code] = 'validation_errors'
      res[:problem] = model.errors.full_messages.join(', ')
      res[:validation_errors] = model.errors
    end
    res
  end

  def record_not_found(err)
    res = {
      code: "record_not_found",
      error: err.to_s
    }        
    render json: res, status: 404
  end
end
