require 'spec_helper'

RSpec.describe Togls::Rules::Boolean do
  describe '.title' do
    it 'does not raise an error' do
      Togls::Rules::Boolean.title
    end
  end

  describe '.description' do
    it 'does not raise an error' do
      Togls::Rules::Boolean.description
    end
  end

  describe '.target_type' do
    it 'returns none' do
      expect(Togls::Rules::Boolean.target_type).to eq(Togls::TargetTypes::NONE)
    end
  end

  describe "#run" do
    it "returns the provided boolean value" do
      bool_rule = Togls::Rules::Boolean.new(:some_rule, :boolean, true)
      expect(bool_rule.run(double)).to eq(true)
    end
  end
end
