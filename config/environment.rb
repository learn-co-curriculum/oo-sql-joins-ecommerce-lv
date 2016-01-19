require 'bundler/setup'
Bundler.require

require_all 'lib'

DB = {
  :connection => SQLite3::Database.new("db/development.sqlite")
}
