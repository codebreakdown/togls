require "togls/version"
require "togls/errors"
require "togls/feature_registry"
require "togls/feature"
require "togls/rule"
require "togls/rules"
require "logger"

module Togls
  def self.default_boolean_rule_klass
    if @default_boolean_rule_klass
      return @default_boolean_rule_klass
    else
      return Togls::Rules::Boolean
    end
  end

  def self.default_boolean_rule_klass=(val)
    @default_boolean_rule_klass = val 
  end

  def self.features(&features)
    if !features.nil?
      @feature_registry = FeatureRegistry.create(&features)
    else
      if @feature_registry.nil?
        raise Togls::NoFeaturesError, "Need to define features before you can get them"
      else
        @feature_registry.registry
      end
    end
  end
  
  def self.feature(key)
    @feature_registry.get(key)
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end
