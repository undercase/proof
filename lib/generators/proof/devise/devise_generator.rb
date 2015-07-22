module Proof
  module Generators
    class DeviseGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "This generator creates a 'login' route, and configures it to work with Devise (with the default model name User)."

      def create_controller
        copy_file "authentication_controller.rb", "app/controllers/authentication_controller.rb"
      end

      def create_routes
        route "post 'login' => 'authentication#login'"
      end
    end
  end
end
