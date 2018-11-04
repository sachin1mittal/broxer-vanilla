puts 'Starting Permissions'

AuthModule::Resources.rebuild_cache
AuthModule::Permissions.new.refresh

resources = Rails.cache.read(AuthModule::Resources::CACHE_KEY)
Role.admin.permissions.push(Permission.where(label: resources['roles permission'].keys))

puts 'Permissions Ends'
