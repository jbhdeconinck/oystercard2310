require './lib/journey'  # ~> LoadError: cannot load such file -- ./lib/journey

describe Journey do

  let(:station) { double(:station) }

  describe '#incomplete?' do
    it 'when initializing' do
      expect(subject).to be_incomplete
    end
    it 'when no entry station given' do
      subject.end_journey(station)
      expect(subject).to be_incomplete
    end

    it 'when no exit station given' do
      subject.start_journey(station)
      subject.end_journey
      expect(subject).to be_incomplete
    end

    it 'when entry and exit station given' do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject).not_to be_incomplete
    end
  end

  describe '#start_journey' do
    it "records entry station" do
      subject.start_journey(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#exit_station' do
    it "records exit station" do
      subject.end_journey(station)
      expect(subject.exit_station).to eq station
    end
    it 'returns the journey' do
      subject.start_journey(station)
      expect(subject.end_journey(station)).to eq station
    end
  end

  context 'when given an exit station' do
    it "records exit station at end of journey" do
      subject.end_journey(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe '#fare' do

    context 'when both entry and exit station are provided' do

      it "returns minimum fare" do
        subject.start_journey(station)
        subject.end_journey(station)
        expect(subject.fare).to eq Journey::MIN_FARE
      end
    end

    context 'when entry or exit station is not provided' do

      it "has a default penalty fare when exit station not specified" do
        subject.start_journey(station)
        subject.end_journey
        expect(subject.fare).to eq Journey::DEFAULT_PENALTY
      end

      it "has a default penalty fare when entry station not specified" do
        subject.start_journey
        subject.end_journey(station)
        expect(subject.fare).to eq Journey::DEFAULT_PENALTY
      end
    end
  end
end

# ~> LoadError
# ~> cannot load such file -- ./lib/journey
# ~>
# ~> /Users/samuel/.rvm/rubies/ruby-2.2.3/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/samuel/.rvm/rubies/ruby-2.2.3/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_friday/spec/journey_spec.rb:1:in `<main>'
