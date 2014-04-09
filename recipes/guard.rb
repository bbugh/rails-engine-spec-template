say "Installing guard..."

inject_into_file GEMSPEC_FILE, before: %r{^end$} do
%{
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-rails'
}
end

bundle

run 'bundle exec guard init'

git_commit "Installed guard"