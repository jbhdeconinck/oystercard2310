require_relative 'station'  # => true
require_relative 'journey'  # => true

class Oystercard

  MAX_BALANCE = 90     # => 90
  MIN_FARE = 1         # => 1
  DEFAULT_BALANCE = 0  # => 0

  attr_reader :balance, :log, :station, :journey  # => nil

  def initialize (balance: DEFAULT_BALANCE, journey: Journey.new)
    @balance = balance                        # => 90
    @log = []                                 # => []
    @journey = journey               # => #<Journey:0x007fa35196b710 @entry_station=nil, @exit_station=nil>
    @station = nil                            # => nil
  end

  def top_up amount
    fail "Over maximum balance of #{MAX_BALANCE}" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    touch_out(nil) if in_journey?                                                     # => nil, nil, nil, nil
    fail "you have insufficient funds, please top up by #{MIN_FARE}" if insufficient_balance?  # => nil, nil, nil, nil
    journey.start_journey(station)                                                             # => #<struct Station name="victoria", zone=2>, #<struct Station name="victoria", zone=2>, #<struct Station name="victoria", zone=2>, #<struct Station name="victoria", zone=2>
  end

  def touch_out(station)
    journey.end_journey(station)  # => #<struct Station name="aldgate", zone=1>, #<struct Station name="aldgate", zone=1>, nil, #<struct Station name="aldgate", zone=1>, #<struct Station name="aldgate", zone=1>
    deduct journey.fare           # => 89, 88, 82, 81, 75
    log_journey                           # => [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="vic...
    journey.reset                 # => nil, nil, nil, nil, nil
  end

  def log_journey
    @log << @journey  # => [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=#<struct Station name="aldgate", zone=1>>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>], [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x...
  end

  def in_journey?
    journey.in_progress?
  end

  private  # => Oystercard

  def full?(amount)
    @balance + amount > 90
  end

  def insufficient_balance?
    @balance < MIN_FARE      # => false, false, false, false
  end

  def deduct amount
    @balance -= amount  # => 89, 88, 82, 81, 75
  end
end


# card = Oystercard.new(90)              # => #<Oystercard:0x007fa35196b918 @balance=90, @log=[], @journey=#<Journey:0x007fa35196b710 @entry_station=nil, @exit_station=nil>, @station=nil>
# victoria = Station.new('victoria', 2)  # => #<struct Station name="victoria", zone=2>
# aldgate = Station.new('aldgate', 1)    # => #<struct Station name="aldgate", zone=1>
#
# card.balance  # => 90
#
# card.touch_in victoria    # => #<struct Station name="victoria", zone=2>
# card.touch_out aldgate    # => nil
# card.journey.incomplete?  # => true
# card.journey.fare         # => 6
# card.balance              # => 89
# card.journey              # => #<Journey:0x007fa35196b710 @entry_station=nil, @exit_station=nil>
#
# card.touch_in victoria      # => #<struct Station name="victoria", zone=2>
# card.touch_out aldgate      # => nil
# card.journey.entry_station  # => nil
# card.journey.exit_station   # => nil
# card.journey.in_progress?   # => false
# card.journey.fare           # => 6
# card.balance                # => 88
#
# card.touch_in victoria      # => #<struct Station name="victoria", zone=2>
# card.balance                # => 88
# card.journey.in_progress?   # => true
# card.touch_in victoria      # => #<struct Station name="victoria", zone=2>
# card.log                    # => [#<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>, #<Journey:0x007fa35196b710 @entry_station=#<struct Station name="victoria", zone=2>, @exit_station=nil>]
# card.journey.entry_station  # => #<struct Station name="victoria", zone=2>
# card.journey.exit_station   # => nil
# card.journey.in_progress?   # => true
# card.journey.fare           # => 6
# card.balance                # => 82
#
# card.touch_out aldgate     # => nil
# card.journey.in_progress?  # => false
#
# card.journey.fare  # => 6
# card.balance       # => 81
#
# card.touch_out aldgate     # => nil
# card.journey.in_progress?  # => false
#
# card.journey.fare  # => 6
# card.balance       # => 75
