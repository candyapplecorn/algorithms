require 'byebug'
require 'rspec'
require 'trio_product'

describe 'LimitedMaxList' do
  let(:lml) { LimitedMaxList.new(3) }


	it 'initializes with an empty list' do
		expect(lml.items).to be_empty
	end

	context 'inserts items correctly' do
		it 'when the length < maxlength' do
			[1, 2].each {|i| lml.insert i }
			expect(lml.items.length).to eq(2)
		end

		it 'when the length >= maxlength' do
			[1, 2, 3, 4].each {|i| lml.insert i }
			expect(lml.items.length).to eq(3)
		end

		it 'removes the smallest item when inserting a bigger one' do
			[1, 2, 3, 4].each {|i| lml.insert i }
			expect(lml.items.min).to eq(2)
		end
	end
end

describe 'LimitedMinList' do
	let(:lml) { LimitedMinList.new(3) }

	it 'initializes with an empty list' do
		expect(lml.items).to be_empty
	end

	context 'inserts items correctly' do
		it 'when the length < maxlength' do
			[1, 2].each {|i| lml.insert i }
			expect(lml.items.length).to eq(2)
		end

		it 'when the length >= maxlength' do
			[1, 2, 3, 4].each {|i| lml.insert i }
			expect(lml.items.length).to eq(3)
		end

		it 'removes the largest item when inserting a bigger one' do
			[1, 2, 3, 4].each {|i| lml.insert i }
			expect(lml.items.max).to eq(3)
		end
	end
end

describe 'trio_product' do
	let(:positives) { [1, 2, 3, 4, 5] }
	let(:negatives) { [-1, -2, -3, -4, -5] }
	let(:both) { [-1, -2, 3, -4, -5] }
	it 'solves the problem with positives' do
		expect(trio_product(positives)).to eq(60)
	end

	it 'solves the problem with negatives' do
		expect(trio_product(negatives)).to eq(-60)
	end

	it 'solves the problem with negatives and positives' do
		expect(trio_product(both)).to eq(60)
	end
end
