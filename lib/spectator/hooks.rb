module SpectatorPlugin
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head,
              :partial => 'hooks/spectator/view_layouts_base_html_head'
  end
end