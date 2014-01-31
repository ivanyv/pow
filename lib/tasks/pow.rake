desc 'Rename app and customize'
task :pow do
  app_root = File.expand_path(File.join(File.dirname(__FILE__), '../..'))
  default_name = File.basename(app_root)
  default_name = default_name.split('_').map(&:capitalize).join('')

  print "New name (#{default_name}): "
  name = STDIN.gets.strip
  name = default_name if name == ''
  name_underscored = name.gsub(/([A-Za-z\d])([A-Z])/, '\1_\2').downcase
  name_dasherized = name_underscored.tr('_', '-')

  # Concatenated so sed doesn't mess up this file
  { 'A' + 'ppName'    => name,
    '<' + 'app_name>' => name_underscored,
    '<' + 'app-name>' => name_dasherized
  }.each do |find, replace|
    system "find #{app_root} -type f -exec sed -i 's/#{find}/#{replace}/g' {} \\;"
  end

  require 'securerandom'
  key = SecureRandom.hex(64)
  system "sed -i 's/<secret_key_base_development>/#{key}/g' #{app_root}/.env.development"
  key = SecureRandom.hex(64)
  system "sed -i 's/<secret_key_base_test>/#{key}/g' #{app_root}/.env.test"

  # Remove our tracks
  File.delete __FILE__
  File.delete File.join(app_root, 'README.md')
  File.rename File.join(app_root, 'APP_README.md'), File.join(app_root, 'README.md')

  system 'git add -u . && git commit -m "Customizations."'
  system 'git remote rm origin'
  system 'rake app:bootstrap'

  puts
  puts "Done!"
end
