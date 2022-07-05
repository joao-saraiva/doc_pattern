# frozen_string_literal: true

require_relative "doc_pattern/version"
require_relative "string"
require "json"
require "byebug"

# This class represent the validation of a file, based on a json model
class DocPattern
  attr_accessor :valid_sub_keys

  def initialize(path)
    self.valid_sub_keys = %w[separator field_type field_pattern line_length minimal_elements
                             max_elements].freeze

    file = File.read(path)
    @doc_pattern = JSON.parse(file)
    @keys = @doc_pattern.keys if @doc_pattern.instance_of?(Hash)
  end

  def sorted_line_keys
    @sorted_line_keys ||= @doc_pattern.keys.select { |key| key.include?("line_") }.sort @doc_pattern.instance_of?(Hash)
  end

  def valid?
    if @doc_pattern.instance_of?(Hash) && @keys

      has_specif_line_rule = @keys.any? { |key| key.include?("line_") }
      has_every_line_rule = @keys.include?("every_line")

      return (has_every_line_rule && !has_specif_line_rule) || (!has_every_line_rule && has_specif_line_rule)
    end

    false
  end

  def invalid?
    !valid?
  end
end
