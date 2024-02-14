require 'bundler/setup'
Dir[File.join(__dir__, 'support', '*.rb')].each { |f| require f }
require 'coda_docs'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ENV['CODA_DOCS_API_KEY'] ||= 'dummy_api_key'
  ENV['STATIC_TABLE_ID'] ||= 'grid-7wlFDEirg4'
end
