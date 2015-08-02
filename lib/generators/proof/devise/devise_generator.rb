module Proof
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      desc "This generator creates a 'login' route, and configures it to work with Devise (with the default model name User)."

      def create_controller
        controller_file = "authentication_controller.rb"
        destination_file = "app/controllers/authentication_controller.rb"
        copy_file controller_file, destination_file
      end

      def create_routes
        route "post 'login' => 'authentication#login'"
      end
    end
  end
end
