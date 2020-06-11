class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  
  def bot
    body = params["Body"].downcase
    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      index = ::Faq::QUESTIONS.map(&:downcase).find_index(body)
      answer = ::Faq::ANSWERS[index] if index
      if answer
        message.body answer
      else
        message.body "No answer"
      end
    end
    render xml: response.to_xml  
  end  
end
