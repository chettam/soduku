require_relative '../lib/cell'

describe Cell do
	let(:cell) {Cell.new}
	context "should contain" do
		
		it "nil when empty" do
			expect(cell.value).to be_nil
		end

		it "a value" do
			expect(cell.value =3).to eq(3)
		end

		it "a value between 0 and 9" do
			cell.value = 200
			expect(cell.value).to be_nil
		end

		it "potential candidates" do
			cell.candidates = 2
			expect(cell.candidates).to eq([2])
		end

		it " cell and box position" do
			expect(cell.position.class).to eq(Hash)
		end
	end

	context "should know" do

		it "if it is filled out" do
			cell.value = 2
			expect(cell.filled_out?).to be_true
		end

		it "0 is not a filled out number" do
			cell.value = 0
			expect(cell.filled_out?).to be_false
		end

		it "how to remove a candidate" do
			cell.candidates = 2
			cell.candidates = 3
			cell.remove_candidate(2)
			expect(cell.candidates).to eq([3])
		end

		it "how to fill out a cell" do
			cell.candidates = 2
			cell.solve!
			expect(cell.filled_out?)
		end

	end

end