# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_engcast_session',
  :secret      => '6bfb8fdd000b1e625a1b98a91f8e92302af19b403864dec625fd2413616c746897b5bea437365cb133c4fb6c5a8fc6a0ee8f0f7f6c5346f3e80c36dec5b8756b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
