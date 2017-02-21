require 'spectator'

Redmine::Plugin.register :spectator do
  name 'Spectator plugin'
  author 'Alexey Pisarenko'
  description 'Plugin for logging as another user'
  version '0.0.2'
  url 'https://github.com/alpcrimea/redmine-spectator-plugin'
  author_url 'https://github.com/alpcrimea'

  menu :account_menu, :spectator, { :controller => 'spectator', :action => 'index' }, :caption => :change_user, :if => Proc.new { User.current.admin? || spectator_id }
end
