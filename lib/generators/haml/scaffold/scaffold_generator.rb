require 'rails/generators/erb/scaffold/scaffold_generator'

module Haml
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path('templates', __dir__)

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions(view)
          template "#{view}.html.haml", File.join("app/views", controller_file_path, filename)
        end

        # Generate the modal templates
        modal_views = %w(_destroy_modal _edit_modal _form_modal _index _show _show_modal)
        modal_views.each do |view|
          template "#{view}.html.haml", File.join("app/views", controller_file_path, "#{view}.html.haml")
        end
      end

      def available_views
        %w(index edit show new _form)
      end

      private

      def handler
        :haml
      end
    end
  end
end
