module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def login(user)
    post '/api/login', params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
end
