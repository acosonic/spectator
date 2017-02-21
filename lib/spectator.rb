Rails.configuration.to_prepare do
	require 'spectator/patches/application_controller_patch'
  require 'spectator/hooks'
end