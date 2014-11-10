class ContactController < ApplicationController
  def create
    respond_to do |format|
      format.html {}
      format.js do
        render json: {status: "OK", message: "Your message was received!"}
      end
    end
  end
end
