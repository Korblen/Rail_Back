# app/controllers/custom_failure.rb
class CustomFailure < Devise::FailureApp
    def respond
      if request.format.json?
        json_failure
      else
        super
      end
    end
  
    def json_failure
      self.status = 401
      self.content_type = 'application/json'
      self.response_body = { error: i18n_message }.to_json
    end
  end
  