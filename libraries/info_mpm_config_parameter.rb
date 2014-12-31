require_relative 'dsl_mpm_config_parameter'

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

    def default_value_for(version, mpm, parameter)
      MPMConfigInfo.find httpd_version: version, mpm_model: mpm, parameter: parameter
    end
  end
end
