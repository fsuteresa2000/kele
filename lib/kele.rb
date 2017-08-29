require 'HTTParty'


class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1/'

  def initialize(email, password)
    self.class.post(sessions_url, attributes: { email: email, password: password } )
    @auth_token = response["auth_token"]
  end

  private
  def sessions_url
    "https://www.bloc.io/api/v1"
  end
end
