class AuthenticationTokenService
  @token_conf = {
    secret: "my$ecretK3y",
    algorithm: "HS256"
  }
  def self.encode(user_id)
    exp = (Time.now + 30.minutes).to_i
    payload = {user_id: user_id, exp: exp}
    JWT.encode payload, @token_conf[:secret], @token_conf[:algorithm]
  end

  def self.decode(token)
    decoded_token = JWT.decode token, @token_conf[:secret], true, {algorithm: @token_conf[:algorithm]}
    decoded_token[0]
  end
end
