RSpec.configure do |config|
  # Configure user authentication skipping tags
  config.before(:each, skip_auth: true) do
    allow_any_instance_of(AuthController).to receive(:authenticate_user!)
  end
end
