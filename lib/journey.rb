class Journey

attr_reader :journey, :entry_station, :exit_station  # => nil

MIN_FARE = 1         # => 1
DEFAULT_PENALTY = 6  # => 6

def initialize(station=nil)
  @entry_station = nil   # => nil
  @exit_station = nil        # => nil
end

def start_journey(station=nil)
  @entry_station = station      # => :station, nil, :station
end

def end_journey(station=nil)
  @exit_station = station                                                 # => nil, :station, :station                                                  # => nil, nil, nil
end

def in_progress?
  !entry_station.nil?
end

def reset
  @exit_station = nil                                                     # => nil, nil, nil
  @entry_station = nil
end

def fare
  incomplete? ? DEFAULT_PENALTY : MIN_FARE
end

def incomplete?
  entry_station.nil? || exit_station.nil?
end

end

# journey = Journey.new            # => #<Journey:0x007fabe2070518 @complete=true>
# journey.start_journey(:station)  # => :station
# journey.end_journey(nil)         # => #<Journey:0x007fabe2070518 @complete=false, @entry_station=nil, @exit_station=nil>
# journey.complete?                # => false
# journey.start_journey(nil)       # => nil
# journey.end_journey(:station)    # => #<Journey:0x007fabe2070518 @complete=false, @entry_station=nil, @exit_station=nil>
# journey.complete?                # => false
# journey.start_journey(:station)  # => :station
# journey.end_journey(:station)    # => #<Journey:0x007fabe2070518 @complete=true, @entry_station=nil, @exit_station=nil>
# journey.complete?                # => true
# :exit_station && nil ? complete = true : complete = false  # => false
# complete                                                   # => false
