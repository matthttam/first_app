module MicropostsHelper
  def wrap(content)
    # OK... so here goes...
    # take content and split by space (default)
    # take this array of split words and map to the block {} where s is each word
    # send s to wrap-long_string function below
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private

    def wrap_long_string(text, max_width = 30)
      # Zero Width Space is the special character
      # that allow html to split a long string into a new line if the box is
      # too long without actually changing the text
      #
      # the regex is looking for any character between length 1 and 30
      # more than 30 will be split
      # then we join with the zero width space
      #
      # We only do the regex and what not if the text.length < max_width (ternary expression)
      # Expression ? do_if_true : do_if_false

      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
    end
end