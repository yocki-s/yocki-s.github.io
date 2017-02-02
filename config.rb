require "./lexer_patch"

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
with_layout :id_layout do
  page "/id/*"
end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

page "404.html", :layout => false
page "sitemap.xml", :layout => false
page "en/api/methods.html", :layout => "layout_methods"
page "id/api/methods.html", :layout => "id_layout_methods"
# page '/id/vtdirect/two_clicks.html', :layout => 'id_without_pagination'
# page '/vtdirect/two_clicks.html', :layout => 'without_pagination'

###
# Helpers
###

activate :syntax, :line_numbers => false
#set :markdown_engine, :redcarpet
#set :markdown, fenced_code_blocks: true, smartypants: true, tables: true, superscript: true, footnotes: true

#set :syntax_theme, Rouge::Themes::Github

set :relative_links, true
set :strip_index_file, false


helpers do

  def print_link(url, lang="en") 
    if ! url.start_with?("http")
      url = "/" + lang + url
    end

    return url    
  end

  def navigate_to(title, url, lang="en")
    final_url = print_link(url, lang) 
    is_active = same_url_starter(current_page.url, final_url) ? 'active' : ''

    return "<li class=\"#{is_active}\">#{ link_to(title, final_url) }</li>"
  end

  def lang_link(lang="en")
    return current_page.url.sub(/(en|id)/, lang)
  end

begin
  def check_id_url(label, url, the_class)
    if ! url.start_with?("http")
      url = "/id" + url
    end
    link_to(label, url, class:the_class)
  end

=begin
  def navigate_to(title, url, lang)
    prefix = (lang == "en") ? "" : "/id"
    final_url = prefix + url
    is_active = same_url_starter(current_page.url, final_url) ? 'active' : ''
    "<li class=\"#{is_active}\">#{link_to title, final_url}</li>"
  end
=end

  def navigate_to_id(title,url)
    navigate_to(title, url, "id")
  end

  def navigate_to_en(title, url)
    navigate_to(title, url, "en")
  end

  def id_link
    "../id/" + current_page.path
  end

  def is_in_menu(submenus, lang)
    prefix = (lang == "en") ? "" : "/id"
    submenus.each do |submenu|
      if same_url_starter(current_page.url, prefix + submenu.link)
        return true
      end
    end
    return false
  end

  def is_in_en_menu(submenus)
    return is_in_menu(submenus, "en")
  end

  def is_in_id_menu(submenus)
    return is_in_menu(submenus, "id")
  end

  def en_link
    path = current_page.path.to_s.dup
    path.slice!(0,3)
    "../../" + path
  end
end

  # def find_index(arr, target_element)
  #   arr.each_with_index do |element, index|
  #     if element
  #   end
  # end

  def same_url_starter(string1, string2)
    n = 6 
    a = string1[0.. (string1.length-n)]
    b = string2[0.. (string2.length-n)]
    status = a.start_with?(b)
    return status
  end

  def kramdown(content)
      Kramdown::Document.new(content).to_html
  end

  def core_paginate(lang, lang_dictionary)
    title = ""
    nav = []
    active_index = 0
    counter = 0

    data.navigation.each do |menu_key, menu_content|
      menu_content.submenu.each do |submenu_item|
        active_label = submenu_item[lang]
        active_url = "/" + lang + submenu_item.link
        
        
        if same_url_starter(current_page.url,active_url)
          title = menu_content.label[lang] + " : " + active_label
          active_index = counter
        end
        nav << [menu_content.label[lang] + " : " + active_label, active_url]
        counter = counter + 1
      end
    end

    #search
    i = active_index
    link_string = "<ul>"

    unless i == 0
      previous_string = lang_dictionary["Previous"]
      link_string += '<li class="left">« ' + previous_string + ': '
      link_string += link_to nav[i-1][0].to_s, nav[i-1][1].to_s
      link_string += "</li>"
    end
    
    unless i == (nav.count - 1)
      next_string = lang_dictionary["Next"]
      link_string += '<li class="right">' + next_string + ': '
      link_string += link_to nav[i+1][0].to_s, nav[i+1][1].to_s
      link_string += ' »</li>'
    end
    
    link_string += "</ul>"
  end

  def en_core_paginate()
    en_dictionary = {"Next" => "Next", "Previous" => "Previous"}
    core_paginate("en", en_dictionary)
  end

  def id_core_paginate()
    id_dictionary = {"Next" => "Selanjutnya", "Previous" => "Sebelumnya"}
    core_paginate("id", id_dictionary)
  end

end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload
I18n.enforce_available_locales = false

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css
  ignore "*.less"
  ignore "less/*"

  after_configuration do
    Dir.chdir "source/stylesheets" do
      puts "Compiling less!!!"
      `lessc ../less/style.less style.css`
      true
    end
  end

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  ignore 'stylesheets/*.less'
end

set :build_dir, 'public'
page "/index.html", :layout => "redirect"