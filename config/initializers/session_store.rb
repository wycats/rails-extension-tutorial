# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_depot_session',
  :secret      => 'dea0f518ecfc11e8c3d6ccc0e5ee4233bd3bef8f61fe74a50a68335e3255343bc48c8f1394b10c34398e2ee2f1954ac6dbc99e559981e6e8669fa84ef7ec4e81'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#START:session
ActionController::Base.session_store = :active_record_store
#END:session
