guard :bundler do
  watch 'Gemfile'
end

guard 'rails', zeus: true do
  watch 'Gemfile.lock'
  watch %r{^(config|lib)/.*}
  ignore %r{^config/deploy\.rb}
  ignore %r{^config/routes\.rb}
end

guard :test, zeus: true do
  watch %r{^test/.+_test\.rb$}
  watch('test/test_helper.rb') { 'test' }

  watch(%r{^app/(.+)\.rb})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb})                               { |m| "test/lib/#{m[1]}_test.rb" }
end
