require 'forwardable'
module Togls
  # Toggle Toggler
  #
  # The Toggle Toggler provides the convenience interface of being able to
  # toggle a feature on/off via the `on` or `off` methods respectively.
  class Toggler
    extend Forwardable
    def_delegators :@toggle, :on?, :off?, :feature, :rule

    def initialize(toggle_repository, toggle)
      @toggle_repository = toggle_repository
      @toggle = toggle
    end

    def on(rule = nil)
      rule = Togls::Rules::Boolean.new(:on, :boolean, true) if rule.nil?
      @toggle.rule = rule
      @toggle_repository.store(@toggle)
      @toggle
    end

    def off
      rule = Togls::Rules::Boolean.new(:off, :boolean, false)
      @toggle.rule = rule
      @toggle_repository.store(@toggle)
      @toggle
    end
  end
end
