class CallbacksController < ApplicationController
  def index
    if params["hub.verify_token"] = "abcdef"
      render text: params["hub.challenge"]
    end
  end

  def recieved_data
  end
end
