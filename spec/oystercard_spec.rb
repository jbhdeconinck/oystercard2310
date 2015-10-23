require 'oystercard'

describe Oystercard do

  let(:max) {Oystercard::MAX_BALANCE}
  let(:min) {Oystercard::MIN_FARE}
  let(:station) { double(:station, name: "Aldgate", zone: "1") }
  let(:journey) { double(:journey)}

  it 'balance is zero when initialized' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'balance increases by top up amount' do
      expect {subject.top_up 1}.to change{subject.balance}.by 1
    end
    it 'error if over maximum balance' do
      error = "Over maximum balance of #{max}"
      expect { subject.top_up(max + 1)}.to raise_error error
    end
  end

  describe '#touch_in' do

      before 'checks balance before use' do
        subject.top_up(1)
      end

      it 'checks you cant touch in with less than minimum balance' do
        subject.touch_in(station)
        subject.touch_out(station)
        error2 = "you have insufficient funds, please top up by #{min}"
        expect {subject.touch_in(station)}.to raise_error error2
      end

      it 'touching in provides journey with an entry station' do
        allow(journey).to receive(:station)
        #subject.touch_in(station)
        #expect(subject.in_journey?).to eq true
      end
    end

    describe '#touch_out' do
      before(:each) do
        subject.top_up(1)
        subject.touch_in(station)
      end

      it 'check balance changes at touch out by minimum balance' do
        expect { subject.touch_out(station) }.to change{ subject.balance }.by(-min)
      end

      it 'touching out changes journey status to not be in journey' do
        #subject.touch_out(station)
        #expect(subject.in_journey?).to eq false
      end

    let(:journey){ {:entry_station => station, :exit_station => station} }
    it {is_expected.to respond_to(:touch_in).with(1).argument}

    it 'checks touching out logs the journey' do
      subject.touch_out(station)
      expect(subject.log).to eq [journey]
    end

    it 'forgets the entry station upon touching out' do
      subject.touch_out(station)
      expect(subject.station).to eq nil
    end
  end


end
