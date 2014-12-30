require_relative 'mpm_config_parameter_dsl'

module HttpdCookbook
  module Helpers
    class MPMConfigInfo
      extend MPMConfigParameterDSL

      # http://httpd.apache.org/docs/2.2/mod/mpm_common.html
      # http://httpd.apache.org/docs/2.4/mod/mpm_common.html

      config for: { httpd_version: '2.2', mpm_model: 'prefork' },
             are: {
               startservers: '5',
               minspareservers: '5',
               maxspareservers: '10',
               maxclients: '150',
               maxrequestsperchild: '0',
               minsparethreads: nil,
               maxsparethreads: nil,
               threadlimit: nil,
               threadsperchild: nil,
               maxrequestworkers: nil,
               maxconnectionsperchild: nil
             }

      config for: { httpd_version: '2.2', mpm_model: 'worker' },
             are: {
               startservers: '2',
               minspareservers: nil,
               maxspareservers: nil,
               maxclients: '150',
               maxrequestsperchild: '0',
               minsparethreads: '25',
               maxsparethreads: '75',
               threadlimit: '64',
               threadsperchild: '25',
               maxrequestworkers: nil,
               maxconnectionsperchild: nil
             }

      config for: { httpd_version: '2.2', mpm_model: 'event' },
             are: {
               startservers: '2',
               minspareservers: nil,
               maxspareservers: nil,
               maxclients: '150',
               maxrequestsperchild: '0',
               minsparethreads: '25',
               maxsparethreads: '75',
               threadlimit: '64',
               threadsperchild: '25',
               maxrequestworkers: nil,
               maxconnectionsperchild: nil
             }

      config for: { httpd_version: '2.4', mpm_model: 'prefork' },
             are: {
               startservers: '5',
               minspareservers: '5',
               maxspareservers: '10',
               maxclients: nil,
               maxrequestsperchild: nil,
               minsparethreads: nil,
               maxsparethreads: nil,
               threadlimit: nil,
               threadsperchild: nil,
               maxrequestworkers: '150',
               maxconnectionsperchild: '0'
             }

      config for: { httpd_version: '2.4', mpm_model: 'worker' },
             are: {
               startservers: '2',
               minspareservers: nil,
               maxspareservers: nil,
               maxclients: nil,
               maxrequestsperchild: nil,
               minsparethreads: '25',
               maxsparethreads: '75',
               threadlimit: '64',
               threadsperchild: '25',
               maxrequestworkers: '150',
               maxconnectionsperchild: '0'
             }

      config for: { httpd_version: '2.4', mpm_model: 'event' },
             are: {
               startservers: '2',
               minspareservers: nil,
               maxspareservers: nil,
               maxclients: nil,
               maxrequestsperchild: nil,
               minsparethreads: '25',
               maxsparethreads: '75',
               threadlimit: '64',
               threadsperchild: '25',
               maxrequestworkers: '150',
               maxconnectionsperchild: '0'
             }
    end

    #######
    # FIXME: There is a LOT of duplication here..
    # There has to be a less gnarly way to look up this information. Refactor for great good!
    #######
    class Pkginfo
      def self.pkginfo
        # Autovivification is Perl.
        @pkginfo = Chef::Node.new

        @pkginfo.set['amazon']['2013.03']['2.2']['package_name'] = 'httpd'
        @pkginfo.set['amazon']['2013.09']['2.4']['package_name'] = 'httpd24'
        @pkginfo.set['amazon']['2014.03']['2.4']['package_name'] = 'httpd24'
        @pkginfo.set['amazon']['2014.09']['2.4']['package_name'] = 'httpd24'
        @pkginfo.set['debian']['10.04']['2.2']['package_name'] = 'apache2'
        @pkginfo.set['debian']['12.04']['2.2']['package_name'] = 'apache2'
        @pkginfo.set['debian']['13.04']['2.2']['package_name'] = 'apache2'
        @pkginfo.set['debian']['13.10']['2.2']['package_name'] = 'apache2'
        @pkginfo.set['debian']['14.04']['2.4']['package_name'] = 'apache2'
        @pkginfo.set['debian']['7']['2.2']['package_name'] = 'apache2'
        @pkginfo.set['debian']['jessie/sid']['2.4']['package_name'] = 'apache2'
        @pkginfo.set['fedora']['20']['2.4']['package_name'] = 'httpd24'
        @pkginfo.set['fedora']['21']['2.4']['package_name'] = 'httpd24'
        @pkginfo.set['ominos']['151006']['2.0']['package_name'] = 'apache22'
        @pkginfo.set['rhel']['5']['2.2']['package_name'] = 'httpd'
        @pkginfo.set['rhel']['6']['2.2']['package_name'] = 'httpd'
        @pkginfo.set['rhel']['7']['2.4']['package_name'] = 'httpd'
        @pkginfo.set['smartos']['5.11']['2.0']['package_name'] = 'apache'
        @pkginfo.set['smartos']['5.11']['2.2']['package_name'] = 'apache'
        @pkginfo.set['smartos']['5.11']['2.4']['package_name'] = 'apache'
        @pkginfo
      end
    end

    ## MPM section
    def default_value_for(version, mpm, parameter)
      MPMConfigInfo.find httpd_version: version, mpm_model: mpm, parameter: parameter
    end

    def default_httpd_version_for(platform, platform_family, platform_version)
      keyname = keyname_for_service(platform, platform_family, platform_version)
      Pkginfo.pkginfo[platform_family][keyname]['default_version']
    rescue NoMethodError
      nil
    end

    def package_name_for(platform, platform_family, platform_version, version)
      keyname = keyname_for_service(platform, platform_family, platform_version)
      Pkginfo.pkginfo[platform_family][keyname][version]['package_name']
    rescue NoMethodError
      nil
    end

    def keyname_for_service(platform, platform_family, platform_version)
      return platform_version.to_i.to_s if platform_family == 'rhel'
      return platform_version if platform_family == 'rhel' && platform == 'amazon'
      return platform_version if platform_family 'fedora'
      return platform_version if platform_family == 'smartos'
      return platform_version if platform_family == 'omnios'
      return platform if platform == 'ubuntu'
      return platform_version if platform_version =~ /sid$/
      return platform_version.to_i.to_s if platform_family == 'debian'
    end
  end
end
