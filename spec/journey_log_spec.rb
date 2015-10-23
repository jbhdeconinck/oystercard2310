require 'journey_log'

describe JourneyLog do

let(:journey_klass) { double(:journey_klass) }
let(:journey) {double(:journey)}
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

end
