# frozen_string_literal: true

require_relative 'doc_pattern/version'
require 'json'
require 'byebug'

class DocPattern
  VALID_SUB_KEYS = ['separator', 'field_type', 'field_pattern', 'line_length', 'minimal_elements', 'max_elements'].freeze

  class Error < StandardError; end

  def read_json(path)
    file = File.read(path)
    @doc_pattern = JSON.parse(file)
  end

  def valid?
    if @doc_pattern != nil && @doc_pattern.class.name.eql?('Hash')
      return false if @doc_pattern.keys.empty?

      has_specif_line_rule = @doc_pattern.keys.any? {|key| key.include?('line_') }
      has_every_line_rule = @doc_pattern.keys.include?('every_line')

      return (has_every_line_rule && !has_specif_line_rule) || (!has_every_line_rule && has_specif_line_rule)
    end

    return false
  end

  def invalid?
    !valid?
  end
end
