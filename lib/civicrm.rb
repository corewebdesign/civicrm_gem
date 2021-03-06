require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext/module'
require 'active_support/core_ext/hash'
require 'active_support/inflector'
require 'active_support/hash_with_indifferent_access'
require 'active_support/callbacks'

require 'rest-client'
require 'nokogiri'
require 'active_model'
require 'dalli'

# cache
require 'civicrm/cache/helpers'
require 'civicrm/cache/config'
require 'civicrm/cache/store'

# utils
require 'civicrm/client'
require 'civicrm/json'
require 'civicrm/resource'
require 'civicrm/version'

# actions
require 'civicrm/actions/relation'
require 'civicrm/actions/create'
require 'civicrm/actions/get_count'
require 'civicrm/actions/update'
require 'civicrm/actions/destroy'
require 'civicrm/actions/find'
require 'civicrm/actions/saveable'
require 'civicrm/actions/all'

# exceptions
require 'civicrm/errors'

# resources
require 'civicrm/resources/base'


module CiviCrm
  extend CiviCrm::Cache::Store

  @@api_key = nil
  @@site_key = nil
  @@api_base = 'https://www.example.org/path/to/civi/codebase'
  @@api_version = 'v3'
  @@user_authenticated = false
  @@time_zone = ActiveSupport::TimeZone['UTC']
  @@default_row_count = 100

  mattr_accessor :api_key, :api_base, :api_version, :site_key, :time_zone, :default_row_count

  def self.api_url(path = '')
    base = "#{api_base}/civicrm/extern/rest.php?#{path}"
    base += "&api_key=#{@@api_key}" if @@api_key
    base += "&key=#{@@site_key}" if @@site_key
    base
  end

  def self.authenticate(name, password)
    auth = Client.request(:post, q: 'civicrm/login', name: name, pass: password)
    @@api_key = auth[0]['api_key']
  end
end
