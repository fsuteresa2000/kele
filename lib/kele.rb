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
