RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.include ActionDispatch::TestProcess
  FactoryBot::SyntaxRunner.class_eval { include ActionDispatch::TestProcess }
end
