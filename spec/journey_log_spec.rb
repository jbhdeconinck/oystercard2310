require 'journey_log'

describe JourneyLog do

let(:journey_klass) { double(:journey_klass) }
let(:journey) {double(:journey, exit_station: station, end_journey: station, entry_station: station)}
let(:station) {:station}

subject(:journey_log) {described_class.new(journey_klass: journey_klass)}

describe "#start_journey" do
  before do
    allow(journey_klass).to receive(:new).with(:station).and_return(journey)
  end

  it "stores a journey" do
    journey_log.start_journey(station)
    expect(journey_log.journeys).to include(journey)
  end
end

describe '#exit_journey' do
   before do
     allow(journey_klass).to receive(:new).with(:station).and_return(journey)
   end

   it 'adds a exit station to the current journey' do
     journey_log.start_journey(station)
     expect(journey_log.exit_journey station).to eq journey_log.journeys.last.exit_station
   end
 end

describe '#show_journeys' do

  it 'returns an array of past journeys' do
    allow(journey_klass).to receive(:new).with(:entry_station).and_return(journey)
    journey_log.start_journey(:entry_station)
    # journey_log.exit_journey(:exit_station)
    expect(journey_log.show_journeys.first.entry_station).to eq(station)
    # expect(journey_log.show_journeys.first.exit_station).to eq(:exit_station)
  end
end

end
