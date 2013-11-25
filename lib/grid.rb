class Grid

		SIZE = 81
		MAXENUM = 6
		attr_reader :cells

	def initialize
		@cells =[]
		@solved = false

	end

	def solved?
		@cells.all? {|cell| cell.filled_out? }
	end

	def create(puzzle)	
		puzzle.chars.each_with_index do |number, index|
			cell = Cell.new(number.to_i,index)
			cells << cell	
		end
	end

	def next_cell 
	 	cells.select {|cell| !cell.filled_out? }.sample 	
	end

	def update_candidates(origin_cell)
			horizontal_candidates_for(origin_cell)
			vertical_candidates_for(origin_cell)
			box_candidates_for(origin_cell)
	end

	def horizontal_candidates_for(cell)		
		update_candidates_for(cell, :x)
	end

	def vertical_candidates_for(cell)		
		update_candidates_for(cell, :y)
	end

	def box_candidates_for(cell)		
		update_candidates_for(cell, :box)
	end

	def update_candidates_for(origin_cell,area)
		 cells.each do |cell| 
		 		if cell.same_position_as?(origin_cell, area) && cell.filled_out?
		 			origin_cell.remove_candidate(cell.value)
		 		end		 		
		 end
	end


  def replicate!
    self.class.new(self.to_s)
  end

  def steal_solution(source)
    initialize_cells(source.to_s)        
  end

  def try_harder
    blank_cell = @cells.reject(&:solved?).first
    blank_cell.candidates.each do |candidate|
      blank_cell.assume(candidate)
      board = replicate!
      board.solve!
      steal_solution(board) and return if board.solved?
    end
  end
	def solve_cell(cell)
		update_candidates(cell)
		cell.solve!
	end

	def solve
		count = 0
		while !solved? || count <  SIZE * MAXENUM
			cell = next_cell
			if !cell.nil?
				solve_cell(cell)
				puts to_s
			end
		end
	end

	def to_s
		cells.map(&:value).join
	end
end
	
