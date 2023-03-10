module PostsHelper
  def show_post_body(body)
    word_array = body.split ' '
    if word_array.length > 30
      "#{word_array.slice(0, 30).join(' ')} ..."
    else
      body
    end
  end

  def next?(count, post_per_page, current_page)
    total_pages = (count + post_per_page - 1) / post_per_page
    current_page < total_pages
  end
end
