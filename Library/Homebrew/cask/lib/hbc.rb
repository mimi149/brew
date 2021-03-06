module Hbc; end

require "hardware"
require "hbc/artifact"
require "hbc/audit"
require "hbc/auditor"
require "hbc/cache"
require "hbc/cask"
require "hbc/cask_loader"
require "hbc/without_source"
require "hbc/caskroom"
require "hbc/checkable"
require "hbc/cli"
require "hbc/cask_dependencies"
require "hbc/caveats"
require "hbc/container"
require "hbc/download"
require "hbc/download_strategy"
require "hbc/exceptions"
require "hbc/fetcher"
require "hbc/installer"
require "hbc/locations"
require "hbc/macos"
require "hbc/options"
require "hbc/pkg"
require "hbc/qualified_token"
require "hbc/scopes"
require "hbc/source"
require "hbc/staged"
require "hbc/system_command"
require "hbc/topological_hash"
require "hbc/underscore_supporting_uri"
require "hbc/url"
require "hbc/url_checker"
require "hbc/utils"
require "hbc/verify"
require "hbc/version"
require "utils"

require "vendor/plist/plist"

module Hbc
  include Locations
  include Scopes
  include Options
  include Utils

  def self.init
    Cache.ensure_cache_exists
    Cache.delete_legacy_cache

    Caskroom.migrate_caskroom_from_repo_to_prefix
    Caskroom.ensure_caskroom_exists
  end

  def self.load(query)
    odebug "Loading Cask definitions"
    cask = Source.for_query(query).load
    cask.dumpcask
    cask
  end
end
