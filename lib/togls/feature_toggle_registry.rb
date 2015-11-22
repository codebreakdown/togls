module Togls
  class FeatureToggleRegistry
    def initialize
      @toggle_repository_drivers = [
        Togls::ToggleRepositoryDrivers::InMemoryDriver.new,
        Togls::ToggleRepositoryDrivers::EnvOverrideDriver.new]
      @feature_repository_drivers =
        [Togls::FeatureRepositoryDrivers::InMemoryDriver.new]
      @rule_repository_drivers =
        [Togls::RuleRepositoryDrivers::InMemoryDriver.new]
      @feature_repository = Togls::FeatureRepository.new(@feature_repository_drivers)
      @rule_repository = Togls::RuleRepository.new(@rule_repository_drivers)
      @toggle_repository = Togls::ToggleRepository.new(@toggle_repository_drivers,
                                    @feature_repository, @rule_repository)
      @boolean_true_rule = Togls::Rules::Boolean.new(true)
      @boolean_false_rule = Togls::Rules::Boolean.new(false)
      @rule_repository.store(@boolean_false_rule)
      @rule_repository.store(@boolean_true_rule)
    end

    def self.create(&feature_toggles)
      feature_toggle_registry = self.new
      feature_toggle_registry.instance_eval(&feature_toggles)
      return feature_toggle_registry
    end

    def expand(&block)
      self.instance_eval(&block)
      return self
    end

    def feature(key, desc)
      feature = Togls::Feature.new(key, desc)
      toggle = Togls::Toggle.new(feature)
      @toggle_repository.store(toggle)
      Togls::Toggler.new(@toggle_repository, toggle)
    end

    def get(key)
      toggle = @toggle_repository.get(key.to_s)
      if toggle.is_a?(Togls::NullToggle)
        Togls.logger.warn("Feature identified by '#{key}' has not been defined")
      end
      return toggle
    end

    def all
      @toggle_repository.all
    end
  end
end
