require 'byebug'
require 'rspec'
require 'trio_sum_zero'

describe 'trio_sum_zero' do
  let(:alist){ [1, 2, -3, 0, -1]}

	it 'returns trios of indices whose elements sum to zero' do
		expect(trio_sum_zero(alist).sort).to eq([[0, 1, 2], [0, 3, 4]].sort)
	end
end
