# frozen_string_literal: true

# default module
module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'The Trip Tip'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
