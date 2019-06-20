# frozen_string_literal: true

# Navigation Helper
module NavigationHelper
  def nav_item(name, target, options = nil)
    style = ['nav-item', 'px-1']
    style << 'active' if current_path_under?(options || target)
    content_tag :li, class: style.join(' ') do
      link_to name, target, class: 'nav-link'
    end
  end

  def current_path_under?(path)
    path = url_for(path)
    return false if path == root_path && request.path != path # Exclude / outside home page

    request.path.start_with?(path)
  end
end
