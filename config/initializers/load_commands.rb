Rails.application.config.eager_load_paths += [Rails.root.join('app/commands')]
Rails.application.config.autoload_paths += [Rails.root.join('app/commands')]

# Dir["#{Rails.root}/app/commands/**/*.rb"].each { |file| require file }
