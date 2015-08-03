module Proof
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :class_name, type: :string, default: "User"
      desc "This generator creates a 'login' route, and configures it to work with Devise (with the default model name User)."

      def create_controller
        controller_file = "authentication_controller.rb.erb"
        destination_file = "app/controllers/authentication_controller.rb"
        template controller_file, destination_file
      end

      def create_routes
        route "post 'login', to: 'authentication#login'"
      end
    end
  end
end
