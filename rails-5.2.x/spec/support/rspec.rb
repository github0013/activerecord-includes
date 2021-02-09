RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  config.include ActiveSupport::Testing::TimeHelpers
  config.order = :random
end
