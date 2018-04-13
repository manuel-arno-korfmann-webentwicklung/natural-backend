# Rails.application.config.eager_load_paths += [Rails.root.join('lib')]
# Rails.application.config.autoload_paths += [Rails.root.join('lib')]

# TODO: make autoloading solution work again

Dir["#{Rails.root}/lib/**/*.rb"].each { |file| require file }
