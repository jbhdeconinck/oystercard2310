class JourneyLog

attr_reader :journeys, :journey_klass

def initialize(journey_klass: Journey)
  @journey_klass = journey_klass
  @journeys = []
end

def start_journey(station)
  journeys << journey_klass.new(station)
end



end
