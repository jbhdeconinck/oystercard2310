require 'oystercard'

describe Oystercard do

  let(:max_balance) {Oystercard::MAX_BALANCE}
  let(:min_balance) {Oystercard::MIN_FARE}
  let(:station) { double(:station, name: "Aldgate", zone: "1") }
  let(:journey) { double(:journey, fare: 1, start_journey: station, reset: nil, entry_station: station, exit_station: station, in_progress?: true, end_journey: nil)}
  let(:empty_card) { Oystercard.new }
  subject(:new_card) { Oystercard.new(balance: 20, journey: journey)}

  it 'balance is zero when initialized' do
    expect(empty_card.balance).to eq 0
  end

  describe '#top_up' do
    it 'balance increases by top up amount' do
      expect {new_card.top_up 1}.to change{subject.balance}.by 1
    end
    it 'error if over maximum balance' do
      msg = "Over maximum balance of #{max_balance}"
      expect { empty_card.top_up(max_balance + 1) }.to raise_error msg
    end
  end

  describe '#touch_in' do
    it 'raises error when insufficient balance' do
      msg = "you have insufficient funds, please top up by #{min_balance}"
      expect {empty_card.touch_in(station)}.to raise_error msg
    end
    end

  describe '#touch_out' do
    let(:journey) { double(:journey, fare: 1, start_journey: station, reset: nil, entry_station: station, exit_station: station, in_progress?: false, end_journey: nil)}

    it 'check balance changes at touch out by minimum balance' do
      new_card.touch_in(station)
      expect { new_card.touch_out(station) }.to change{ subject.balance }.by(-min_balance)
    end

    it 'touching out changes journey status to not be in journey' do
      new_card.touch_in(station)
      new_card.touch_out(station)
      expect(new_card.in_journey?).to eq false
    end

    it 'checks touching out logs the journey' do
      new_card.touch_out(station)
      expect(new_card.log).to eq [journey]
    end

    it 'forgets the entry station upon touching out' do
      new_card.touch_out(station)
      expect(new_card.station).to eq nil
    end
  end


end
