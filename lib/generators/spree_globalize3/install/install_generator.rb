module SpreeGlobalize3
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_globalize3\n"
        append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_globalize3\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_globalize3\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_globalize3\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_globalize3'
      end


      def change_routes
        res = ask 'Would you like to alter the Spree routes to handle localized urls (eg. /en/products)? [Y/n]'
        if res == '' || res.downcase == 'y'
          comment_lines File.join('config', 'routes.rb'), /mount Spree::Core::Engine/
          insert_into_file File.join('config', 'routes.rb'), :after => "routes.draw do\n" do
            <<-ROUTES
  root :to => 'spree/locale#detect'
  mount Spree::Core::Engine, :at => '/:locale/', :constraints => { :locale => /\#{I18n.available_locales.join('|')}/ }
            ROUTES
          end
          puts 'Remember to properly set i18n.default_locale and i18n.available_locales in config/application.rb!'
        else
          puts 'Bad bad bad, don\'t forget to handle the locale switch!'
        end
      end



      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end


    end
  end
end
