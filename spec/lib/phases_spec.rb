require 'active_support/all'
require_relative '../../lib/phases'

module Phases
  describe 'phases for dates' do
    Dates = Struct.new(:ideas_phase_due_on, :ideas_selection_phase_due_on)

    before do
      I18n.default_locale = :es
      I18n.load_path << File.expand_path('../../config/locales/phases.es.yml', File.dirname(__FILE__))
    end

    it 'has an ideas phase' do
      dates = Dates.new(1.day.from_now, 2.days.from_now)
      phases = Phases.for_dates(dates)
      phases.map(&:to_s).should include 'ideas'
    end

    it 'has an ideas selection phase' do
      dates = Dates.new(1.day.from_now, 2.days.from_now)
      phases = Phases.for_dates(dates)
      phases.map(&:to_s).should include 'selección de ideas'
    end

    it 'has just one current phase' do
      dates = Dates.new(1.day.from_now, 2.days.from_now)
      phases = Phases.for_dates(dates)
      current = phases.select(&:current?)

      current.count.should eq 1
      current.first.to_s.should eq 'ideas'

      dates = Dates.new(1.day.ago, 2.days.from_now)
      phases = Phases.for_dates(dates)
      current = phases.select(&:current?)

      current.count.should eq 1
      current.first.to_s.should eq 'selección de ideas'
    end
  end
end
