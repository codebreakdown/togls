module Togls
  # Rule
  #
  # The Rule is an abstract base class that is intended to act as an interface
  # for other rules to be implemented against.
  class Rule
    attr_reader :data

    def self.title
      raise Togls::NotImplemented, "Rule type title not implemented"
    end

    def self.description
      raise Togls::NotImplemented, "Rule type description not implemented"
    end

    def initialize(data = nil)
      @data = data
    end

    def run(key, target = nil)
      raise Togls::NotImplemented, "Rule's #run method must be implemented"
    end

    def id
      Togls::Helpers.sha1(self.class, @data)
    end
  end
end
