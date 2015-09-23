class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def error(model)
    res = {
      code: '',
      error: ''            
    }

    unless model.valid? 
      res[:error] = 'Some validation errors have been encountered'
      res[:code] = 'validation_errors'
      res[:problem] = model.errors.full_messages.join(', ')
      res[:validation_errors] = model.errors
    end
    res
  end
end
