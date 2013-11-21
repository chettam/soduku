require_relative '../lib/grid'

describe Grid do
		let(:grid) {Grid.new}

		context "should contain" do

			it "cells" do
				grid.cells.each {|cell| expect(cell).to instance_of(Cell)}
			end 

			it "81 cells" do
				create_grid
				expect(grid.cells.length).to eq(81)
			end		
		end

		context "should know" do

			it "if a grid is solved" do
				expect(grid.solved?).to be_false
			end

			it "how to find the first unsolved cell" do
				create_grid
				expect(grid.search_next_cell).to be_kind_of Cell
			end

			it "to return nil if there is no unsolved cell" do
				grid.create('1')
				expect(grid.search_next_cell).to be_nil
			end

			it "how to calculate x index" do 
			 create_grid
			 expect(grid.calculate_position_x(10)).to eq(1)
			end

			it "how to calculate y index" do 
			 create_grid
			 expect(grid.calculate_position_y(10)).to eq(1)
			end

			it "how to calculate box index" do 
				create_grid
				expect(grid.calculate_position_box(10)).to eq(0)
			end

			it "how to set the position of cells" do
				create_grid
				expect(grid.search_next_cell.position).to eq({:x => 0 ,:y => 0 ,:box =>0})
			end

			it "how to find a cell candidate base on an horizontal row" do
				create_grid
				cell = grid.search_next_cell
				grid.horizontal_candidates_for(cell)
				expect(cell.candidates).to eq([6])
			end

			it "how to find a cell candidate base on an vertical row" do
				create_grid
				cell = grid.search_next_cell
				grid.vertical_candidates_for(cell)
				expect(cell.candidates).to eq([6])
			end

			it "how to find a cell candidate base on a box" do
				create_grid
				cell = grid.search_next_cell
				grid.box_candidates_for(cell)
				expect(cell.candidates).to eq([6])
			end

			it "how to find the minimum amount of candidats for a sell" do
				create_grid
				cell =grid.search_next_cell
				grid.search_all_candidates(cell)
				expect(cell.candidates).to eq([6])
			end

			it "how to solve individual cell" do
				create_grid
				cell = grid.search_next_cell
				grid.search_all_candidates(cell)
				grid.solve_cell(cell)
				expect(cell.filled_out?).to be_true
			end

			it "how to skip tp the next cell if a cell is not solved" do
				create_grid
				cell1 = grid.search_next_cell
				cell2 = grid.search_next_cell
		
				expect(cell1).to eq(cell2)
				# expect(cell3).not_to eq(cell2)
			end

			it "if the soduku is solved" do
			  grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
				grid.solve
			  expect(grid.solved?).to be_true
			end

			it "how to solve an easy soduku" do
				grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
				grid.solve
				expect(grid.cells.map(&:value).join).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
			end
		end
		def create_grid
			# grid.create('015003002000100906270068430490002017501040380003905000900081040860070025037204600')
			grid.create('015493872348127956279568431496832517521746389783915264952681743864379125137254698')
		end

end
