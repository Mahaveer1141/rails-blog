module PostsHelper
  def show_post_body(body)
    word_array = body.split ' '
    if word_array.length > 30
      "#{word_array.slice(0, 30).join(' ')} ..."
    else
      body
    end
  end
end
