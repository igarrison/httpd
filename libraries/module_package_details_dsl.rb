module Httpd
  module Module
    module Helpers
      module ModuleDetailsDSL
        def find_load_files(key)
          found_key = module_details_data.keys.find { |lock| key.merge(lock) == key }
          module_details_data[found_key][:and_load]
        end

        def after_installing(options)
          key = options[:on].merge(package: options[:package])
          actions = options[:chef_should]
          module_details_data[key] = actions
        end

        def module_details_data
          @module_details_data ||= {}
        end
      end
    end
  end
end
