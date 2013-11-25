class Grid

	LENGTH = 9
	BOX_LENGTH = 3

	def initialize
		@cells =[]
		@solved = false
		@last_cell = Cell.new
	end

	attr_reader :cells

	def solved?
		@solved
	end

	def create(puzzle)	
		puzzle.chars.each_with_index do |number, index|
			cell = Cell.new(number.to_i,index)
			cells << cell	
		end
	end

	def build_cell_with(value)
		Cell.new value
	end

  def search_next_cell
	 	@last_cell = select_cell_unless_last(select_next_cell)
	 end

	 def select_cell_unless_last(cell)
	 	@last_cell == cell ? select_next_cell : cell
	 	cell
	 end

	 def select_next_cell 
	 	cells.select {|cell| !cell.filled_out? }.sample
	 end



	def search_all_candidates(origin_cell)
			horizontal_candidates_for(origin_cell)
			vertical_candidates_for(origin_cell)
			box_candidates_for(origin_cell)
	end


	def horizontal_candidates_for(cell)		
		search_candidates(cell, :x)
	end

	def vertical_candidates_for(cell)		
		search_candidates(cell, :y)
	end

	def box_candidates_for(cell)		
		search_candidates(cell, :box)
	end

	def search_candidates(origin_cell,area)
		 cells.each do |cell| 
		 		if cell.same_position_as?(origin_cell, area) && cell.filled_out?
		 			origin_cell.candidates.delete(cell.value)
		 		end		 		
		 end
	end

	


	def solve_cell(cell)
		search_all_candidates(cell)
		cell.solve!
	end

	def solve
		until solved?
			cell = search_next_cell
			if !cell.nil?
				solve_cell(cell)
			else
				@solved = true
			end
		end
		puts cells.map(&:value).inspect
	end
end
	
