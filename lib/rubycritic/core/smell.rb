# frozen_string_literal: true

require 'rubycritic/core/location'

module RubyCritic
  class Smell
    attr_accessor :context, :cost, :locations, :message, :score, :status, :type, :analyser

    def initialize(attributes = {})
      @locations = []
      @status = :new
      attributes.each { |name, value| public_send("#{name}=", value) }
    end

    FLAY_DOCS_URL = 'http://docs.seattlerb.org/flay/'.freeze
    FLOG_DOCS_URL = 'http://docs.seattlerb.org/flog/'.freeze

    def at_location?(other_location)
      locations.any?(other_location)
    end

    def multiple_locations?
      locations.length > 1
    end

    def ==(other)
      state == other.state
    end
    alias eql? ==

    def to_s
      "(#{type}) #{context} #{message}"
    end

    def to_h
      {
        context: context,
        cost: cost,
        locations: locations,
        message: message,
        score: score,
        status: status,
        type: type
      }
    end

    def to_json(*options)
      to_h.to_json(*options)
    end

    def doc_url
      case analyser
      when 'reek'
        "https://github.com/troessner/reek/blob/master/docs/#{dasherized_type}.md"
      when 'flay'
        FLAY_DOCS_URL
      when 'flog'
        FLOG_DOCS_URL
      else
        raise "No documentation URL set for analyser '#{analyser}' smells"
      end
    end

    def hash
      state.hash
    end

    protected

    def state
      [context, message, score, type]
    end

    private

    def dasherized_type
      type.gsub(/(?<!^)([A-Z])/, '-\1')
    end
  end
end
