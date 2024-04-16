class ApplicationController < ActionController::API
  SECRET = "sekret_password"

  def authenticate!
    decode_data = decode_user_data(request.headers["token"])

    return head :forbidden if decode_data.nil?

    user_data = decode_data[0]["user_data"]

    return true if User.exists?(user_data)

    head :forbidden
  end

  def encode_user_data(payload)
    JWT.encode(payload, SECRET, "HS256")
  end

  private

  def decode_user_data(token)
    begin
      JWT.decode(token, SECRET, true, { algorithm: "HS256" })
    rescue => e
      puts e
    end
  end
end