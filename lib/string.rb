# frozen_string_literal: true

# New methods to format my strings
class String
  def until_line_keys
    lines_range = tr("line_", "")
    [lines_range[0].to_i, lines_range[-1].to_i]
  end

  def until_line?
    include?("..")
  end

  def until_line_range
    if until_line?
      lines = []

      (until_line_keys[0]..until_line_keys[1]).each do |line|
        lines.push(line)
      end

      return lines
    end
    []
  end
end
