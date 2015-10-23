# require 'capybara/rspec'
#
# require 'oystercard'
#
# describe 'As a customer' do
#
#   let(:new_card) { Oystercard.new }
#
#   feature 'a new card' do
#     scenario "has a default balance of £#{Oystercard::DEFAULT_BALANCE}" do
#       expect(new_card.balance).to eq Oystercard::DEFAULT_BALANCE
#     end
#
#   feature ''
#     subject {Oystercard.new}
#
#       it 'balance is zero when initialized' do
#         expect(subject.balance).to eq 0
#       end
#
#       describe '#top_up' do
#         it 'balance increases by top up amount' do
#           expect {subject.top_up 1}.to change{subject.balance}.by 1
#         end
#       end
#
#       describe '#max_balance' do
#         it 'error if over maximum balance' do
#           max_balance = Oystercard::MAX_BALANCE
#           error = "Over maximum balance of #{max_balance}"
#           expect {subject.top_up(max_balance +1)}.to raise_error error
#         end
#
#       end
# end
#
#
# rand(10) > 6 ? true : false
