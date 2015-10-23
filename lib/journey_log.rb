require_relative 'journey'  # => true

class JourneyLog

  attr_reader :journeys, :journey_klass  # => nil

  def initialize(journey_klass: Journey)
    @journey_klass = journey_klass        # => Journey
    @journeys = []                        # => []
  end

  def start_journey(station)
    journeys << journey_klass.new(station)  # => [#<Journey:0x007ff72a95ade8 @entry_station=:station, @exit_station=nil>]
  end

  def exit_journey(station)
    journeys.last.end_journey(station)  # => :station
  end

end

log = JourneyLog.new         # => #<JourneyLog:0x007ff72a95b1f8 @journey_klass=Journey, @journeys=[]>
log.start_journey(:station)  # => [#<Journey:0x007ff72a95ade8 @entry_station=:station, @exit_station=nil>]
log                          # => #<JourneyLog:0x007ff72a95b1f8 @journey_klass=Journey, @journeys=[#<Journey:0x007ff72a95ade8 @entry_station=:station, @exit_station=nil>]>
log.exit_journey(:station)   # => :station
log
