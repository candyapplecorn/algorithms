require 'byebug'
require 'rspec'
require 'trio_sum_zero'

describe 'trio_sum_zero' do
  let(:alist){ [1, 2, -3, 0, -1]}
  # this is the list from the readme!
  let(:blist){ [1, 2, -3, 0, 2, -2]}

	it 'returns trios of indices whose elements sum to zero' do
		expect(trio_sum_zero(alist).sort).to eq([[0, 1, 2], [0, 3, 4]].sort)
	end

	it 'gets the correct output as per the example input/output from the README' do
		expect(trio_sum_zero(blist).sort).to eq([[1, 3, 5], [0, 2, 4], [0, 1, 2], [3, 4, 5]].sort)
	end
end
