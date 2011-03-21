# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails-test_session',
  :secret      => '7844b75fba0c692e087f41ad93413934e54adb251daa35d805f881c0bfcec636d4e26e021bf275df3c1f12ea829fe79fe58fd44e7b21401259ff5fde4c5a106d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
