require 'chef/resource/lwrp_base'
require_relative 'helpers'

class Chef
  class Resource
    class HttpdConfig < Chef::Resource::LWRPBase
      self.resource_name = :httpd_config
      default_action :create
      actions :create, :delete

      attribute :config_name, kind_of: String, name_attribute: true, required: true
      attribute :cookbook, kind_of: String, default: nil
      attribute :httpd_version, kind_of: String, default: nil
      attribute :instance, kind_of: String, default: 'default'
      attribute :source, kind_of: String, default: nil
      attribute :variables, kind_of: [Hash], default: nil

      include HttpdCookbook::Service::Helpers

      def parsed_httpd_version
        return httpd_version if httpd_version
        default_httpd_version_for(
          node['platform'],
          node['platform_family'],
          node['platform_version']
        )
      end
    end
  end
end
