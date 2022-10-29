class VerifyUserService
  def initialize(user, password)
    @user = user
    @password = password
  end

  def call
    if @user&.valid_password?(@password)
      token = JsonWebToken.encode(id: @user.id, email: @user.email)
      return token if token.present?
    else
      return []
    end
  end
end
