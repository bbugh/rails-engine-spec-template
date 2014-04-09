say "Installing thin, pry, awesome_print, better_errors, and hirb..."

inject_into_file GEMSPEC_FILE, before: %r{^end$} do 
  %{
  s.add_development_dependency 'thin'
  s.add_development_dependency 'pry-doc'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'hirb'
}
end

bundle

git_commit "Adding development gems"