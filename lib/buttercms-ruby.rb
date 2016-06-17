require 'json'
require 'rest_client'
require 'ostruct'

require 'buttercms/hash_to_object'
require 'buttercms/butter_collection'
require 'buttercms/butter_resource'
require 'buttercms/author'
require 'buttercms/category'
require 'buttercms/post'
require 'buttercms/feed'

# See https://github.com/jruby/jruby/issues/3113
if RUBY_VERSION < '2.0.0'
  require_relative 'core_ext/ostruct'
end

module ButterCMS
  @api_url = 'https://api.buttercms.com/v2'
  @token = nil

  def self.api_token=(token)
    @token = token
  end

  def self.token
    @token
  end

  def self.endpoint
    @api_url
  end

  def self.request(path, options = {})
    raise ArgumentError.new "Please set your API token" unless token

    response = RestClient::Request.execute(
      method: :get,
      url: endpoint + path,
      headers: {
        params: options.merge(auth_token: @token)
      },
      verify_ssl: false
    )

    JSON.parse(response.body)
  end
end

