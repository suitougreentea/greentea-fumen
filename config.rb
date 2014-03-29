require 'rubygems'
require 'middleman/rack'

require 'bootstrap-sass'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :livereload

#run Middleman.server
