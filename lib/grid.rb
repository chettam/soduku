class Grid

	def initialize
		@cells =[]
		@solved = false
		@last_cell = Cell.new
	end

	attr_reader :cells

	def solved?
		@sovled
	end

	def create(puzzle)	
		index =0	
		puzzle.chars do |number|
			cell = Cell.new; cell.value = number.to_i		
			assign_position(cell,index)
			cells << cell	
			index += 1
		end
	end

  def search_next_cell
   	current_cell = cells.detect {|cell| !cell.filled_out?}
	 	cell = @last_cell == current_cell ? cells.detect {|cell| !cell.filled_out? && cell != @last_cell} : current_cell
	 	@last_cell = current_cell
	 	cell
	 end

	def calculate_position_x(index)
		(index % 9)
	end
	
	def calculate_position_y(index)
		(index / 9)
	end

	def calculate_position_box(index)
		(calculate_position_x(index) /3 ) + (calculate_position_y(index) /3 ) * 3
	end

	def assign_position(cell,index)
			cell.position[:x] = calculate_position_x(index)
			cell.position[:y] = calculate_position_y(index)
			cell.position[:box] = calculate_position_box(index)
	end

	def get_candidates(origin_cell)
			get_horizontal_candidates(origin_cell)
			get_vertical_candidates(origin_cell)
			get_box_candidates(origin_cell)
	end


	def get_horizontal_candidates(origin_cell)		
			get_initial_candidates(origin_cell)
		 cells.each do |cell| 
		 		if cell.position[:x] == origin_cell.position[:x] && cell.filled_out?
		 			origin_cell.candidates.delete(cell.value)
		 		end
		 end
	end

	def get_vertical_candidates(origin_cell)		
			get_initial_candidates(origin_cell)
		 cells.each do |cell| 
		 		if cell.position[:y] == origin_cell.position[:y] && cell.filled_out?
		 			origin_cell.candidates.delete(cell.value)
		 		end
		 end
	end

	def get_box_candidates(origin_cell)		
			get_initial_candidates(origin_cell)
		 cells.each do |cell| 
		 		if cell.position[:box] == origin_cell.position[:box] && cell.filled_out?
		 			origin_cell.candidates.delete(cell.value)
		 		end		 		
		 end
	end

	def get_initial_candidates(origin_cell)
		origin_cell.candidates == []
		(1..9).each {|n| origin_cell.candidates << n}  if origin_cell.candidates == []
	end

	def solve_cell(cell)
		cell.solve
	end

	def solve
		while !solved?
			cell = search_next_cell
			if !cell.nil?
				get_candidates(cell)
				solve_cell(cell)
			else
				@solved = true
			end
		end
	end
end
	
