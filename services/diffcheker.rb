require 'htmlentities'

module Services
  class DiffChecker
    def initialize(left, right)
      @left = left.split("\n")
      @right = right.split("\n")
      @left_html = ""
      @right_html = ""
    end

    def call
      check_difference
      {:left => @left_html, :right => @right_html}.to_json
    end

    private

    def check_difference
      @left.each_with_index do |left_line, index|
        right_line = @right[index]

        left_line = "" if left_line == nil
        right_line = "" if right_line == nil

        left_line = left_line.ljust(right_line.length)
        right_line = right_line.ljust(left_line.length)

        check_characters(left_line, right_line)

        if index != @left.length - 1
          @left_html += "<br/>"
          @right_html += "<br/>"
        end
      end
    end

    def check_characters(left_line, right_line)
      for character_index in 0...left_line.length
        left_character = encode_html(left_line[character_index, 1])
        right_character = encode_html(right_line[character_index, 1])

        if left_character == right_character
          @left_html += left_character
          @right_html += right_character
        else
          @left_html += %{<span class="change">#{left_character}</span>}
          @right_html += %{<span class="change">#{right_character}</span>}
        end
      end
    end

    def encode_html(text)
      text = "" if text == nil

      text = ::HTMLEntities.new.encode(text)
      text.gsub(" ", "&nbsp;")
    end
  end
end