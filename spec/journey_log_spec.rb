require 'journey_log'

describe JourneyLog do

let(:journey_klass) { double(:journey_klass) }
let(:journey) {double(:journey, exit_station: station, end_journey: station)}
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
      # allow(journey).to receive(:end_station).with(:station)
    end

    it 'adds a exit station to the current journey' do
      journey_log.start_journey(station)
      expect(journey_log.exit_journey station).to eq journey_log.journeys.last.exit_station
    end
  end


end
