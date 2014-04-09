say "Installing rspec, capybara, factory_girl, ffaker..."

# Add test files
inject_into_file GEMSPEC_FILE, after: /s\.files.*$/ do 
  %{\n  s.test_files = Dir["spec/**/*"]}
end

# Add the gems
inject_into_file GEMSPEC_FILE, before: %r{^end$} do
%{
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
}
end

bundle

generate 'rspec:install'

# Setting default Rake task to :spec
append_to_file 'Rakefile' do 
%{
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')
task :default => :spec
}.strip
end

# Setting rspec and factory_girl as default generators...
insert_into_file "lib/#{name}/engine.rb", after: /isolate_namespace .*$/ do
%{

    config.generators do |g|
      g.test_framework :rspec, fixtures: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
}
end

# Setting up spec helper for engines...

# RSpec doesn't understand engine dummy path, fix that.
gsub_file 'spec/spec_helper.rb', '../../config/environment', '../dummy/config/environment.rb'

# Require factory girl
insert_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl_rails'", after: "require 'rspec/autorun'" 

# Add Factory Girl methods to RSpec, and include the route's url_helpers.
insert_into_file 'spec/spec_helper.rb', before: /^end$/ do 
%{
  config.include FactoryGirl::Syntax::Methods
  config.include #{camelized}::Engine.routes.url_helpers
}
end

git_commit "Installed rspec"