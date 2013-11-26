require_relative '../lib/grid'

describe Grid do
		let(:grid) {Grid.new}

		# before(:each) do
  #   create_grid
  # 	end


		context "should contain" do

			it "81 cells" do
				create_grid
				expect(grid.cells.length).to eq(81)
			end		
		end

		context "should know" do
			it "to return nil if there is no unsolved cell" do
				grid.create('1')
				expect(grid.next_cell).to be_nil
			end

			it "how to set the position of cells" do
				create_grid
				expect(grid.next_cell.position).to eq({:x => 0 ,:y => 0 ,:box =>0})
			end

			

			it "how to find the minimum amount of candidats for a sell" do
				create_grid
				cell = grid.next_cell
				cell.update_candidates(grid)
				expect(cell.candidates).to eq([6])
			end

			it "how to solve individual cell" do
				create_grid
				cell = grid.next_cell
				cell.update(grid)
				expect(cell.filled_out?).to be_true
			end

			it "how to skip tp the next cell if a cell is not solved" do
				create_grid
				cell1 = grid.next_cell
				cell2 = grid.next_cell
		
				expect(cell1).to eq(cell2)

			end

			it "if the soduku is solved" do
			  grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
				grid.solve
			  expect(grid.solved?).to be_true
			end

			it "how to solve an easy soduku" do
				grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
				grid.solve
				expect(grid.to_s).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
			end

			it "how to solve an hard soduku" do
				#seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
				seed = ((1..9).to_a + Array.new(81-9, 0)).shuffle.join
				#seed = "800000000003600000070090200050007000000045700000100030001000068008500010090000400"
				grid.create(seed)
				grid.solve
			  expect(grid.solved?).to be_true
			end

		end
		def create_grid
			# grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
			grid.create('015493872348127956279568431496832517521746389783915264952681743864379125137254698')
		end

end
