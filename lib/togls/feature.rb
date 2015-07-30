module Togls
  class Feature
    attr_reader :key, :description

    def initialize(key, description)
      @key = key
      @description = description
      off
    end

    def on(rule = nil)
      if rule.nil?
        rule = Togls.default_boolean_rule_klass.new(true)
      end
      @rule = rule 
      self
    end

    def off
      @rule = Togls.default_boolean_rule_klass.new(false)
      self
    end

    def on?(target = nil)
      @rule.run(@key, target)
    end

    def to_s
      if @rule.is_a?(Togls.default_boolean_rule_klass)
        display_value = @rule.run(@key) ? ' on' : 'off'
      else
        display_value = '  ?'
      end

      "#{display_value} - #{@key.inspect} - #{@description}"
    end
  end
end
