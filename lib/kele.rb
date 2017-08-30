require_relative 'roadmap'
require 'httparty'
require 'json'


class Kele
  include HTTParty
  include Roadmap

  def base_uri
    'https://www.bloc.io/api/v1'
  end

  def initialize(email, password)
      response = self.class.post( "/sessions", body: {"email": email, "password": password } )
      @auth_token = response["auth_token"]
      if @auth_token.nil?
      puts "Sorry, invalid credentials."
    end
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_availability_data = JSON.parse(response.body)
  end
end

def get_messages(page=nil)
    if page == nil
       response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
    else
       response = self.class.get("/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
    end
     @messages_data = JSON.parse(response.body)
  end

  def create_message(user_email, recipient_id, subject, message)
    response = self.class.post("/messages",
      body: {
        "sender": user_email,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped_text": message
      },
      headers: {"authorization" => @auth_token})
    puts response
  end

end
