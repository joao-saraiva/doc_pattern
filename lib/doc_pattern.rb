# frozen_string_literal: true

require_relative "doc_pattern/version"
require "json"
require "byebug"

# This class represent the validation of a file, based on a json model
class DocPattern
  VALID_SUB_KEYS = %w[separator field_type field_pattern line_length minimal_elements
                      max_elements].freeze

  class Error < StandardError; end

  def read_json(path)
    file = File.read(path)
    @doc_pattern = JSON.parse(file)
  end

  def sorted_line_keys
    @sorted_line_keys ||= @doc_pattern.keys.select { |key| key.include?("line_") }.sort @doc_pattern.instance_of?(Hash)
  end

  def until_line?(key)
    key.include?("..")
  end

  def until_line_range(key)
    if until_line?(key)
      lines = []
      lines_range = key.tr("line_", "")
      first_line = lines_range[0].to_i
      last_line = lines_range[-1].to_i

      (first_line..last_line).each do |line|
        lines.push(line)
      end

      return lines
    end
    []
  end

  def multiple_line(key); end

  def valid?
    if @doc_pattern.instance_of?(Hash)
      return false if @doc_pattern.keys.empty?

      has_specif_line_rule = @doc_pattern.keys.any? { |key| key.include?("line_") }
      has_every_line_rule = @doc_pattern.keys.include?("every_line")

      return (has_every_line_rule && !has_specif_line_rule) || (!has_every_line_rule && has_specif_line_rule)
    end

    false
  end

  def invalid?
    !valid?
  end
end
