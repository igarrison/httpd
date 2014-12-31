# info_service_packages.rb

module HttpdCookbook
  module Helpers
    extend ServicePackageDSL
    
    package_name for: { platform: 'amazon', httpd_version: '2.2' }, is: 'httpd'
    package_name for: { platform: 'amazon', httpd_version: '2.4' }, is: 'httpd24'
    package_name for: { platform: 'fedora', httpd_version: '2.2' }, is: 'httpd'
    package_name for: { platform: 'fedora', httpd_version: '2.4' }, is: 'httpd24'
    package_name for: { platform: 'omnios', httpd_version: '2.2' }, is: 'apache22'
    package_name for: { platform: 'omnios', httpd_version: '2.4' }, is: 'apache24'
    package_name for: { platform: 'smartos', httpd_version: '2.0' }, is: 'apache'
    package_name for: { platform: 'smartos', httpd_version: '2.2' }, is: 'apache'
    package_name for: { platform: 'smartos', httpd_version: '2.4' }, is: 'apache'
    package_name for: { platform_family: 'debian', httpd_version: '2.2' }, is: 'apache2'
    package_name for: { platform_family: 'debian', httpd_version: '2.4' }, is: 'apache2'
    package_name for: { platform_family: 'rhel', httpd_version: '2.2' }, is: 'httpd'
    package_name for: { platform_family: 'rhel', httpd_version: '2.4' }, is: 'httpd'
        
    ## MPM section
    # def default_value_for(version, mpm, parameter)
    #   MPMConfigInfo.find httpd_version: version, mpm_model: mpm, parameter: parameter
    # end

    # def package_name_for(platform, platform_family, platform_version, version)
    #   keyname = keyname_for_service(platform, platform_family, platform_version)
    #   Pkginfo.pkginfo[platform_family][keyname][version]
    # rescue NoMethodError
    #   nil
    # end

    # def keyname_for_service(platform, platform_family, platform_version)
    #   return platform_version.to_i.to_s if platform_family == 'rhel'
    #   return platform_version if platform_family == 'rhel' && platform == 'amazon'
    #   return platform_version if platform_family 'fedora'
    #   return platform_version if platform_family == 'smartos'
    #   return platform_version if platform_family == 'omnios'
    #   return platform if platform == 'ubuntu'
    #   return platform_version if platform_version =~ /sid$/
    #   return platform_version.to_i.to_s if platform_family == 'debian'
    # end
  end
end
