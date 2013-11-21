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
			cell = build_cell_with(number.to_i)
			assign_position(cell,index)
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

	def calculate_position_x(index)
		(index % LENGTH)
	end
	
	def calculate_position_y(index)
		(index / LENGTH)
	end

	def calculate_position_box(index)
		(calculate_position_x(index) / BOX_LENGTH ) + (calculate_position_y(index) / BOX_LENGTH ) * BOX_LENGTH
	end

	def assign_position(cell,index)
			cell.position[:x] = calculate_position_x(index)
			cell.position[:y] = calculate_position_y(index)
			cell.position[:box] = calculate_position_box(index)
	end

	def update_candidates(origin_cell)
			horizontal_candidates_for(origin_cell)
			vertical_candidates_for(origin_cell)
			get_box_candidates(origin_cell)
	end


	def horizontal_candidates_for(cell)		
		get_candidates(cell, :x)
	end

	def vertical_candidates_for(cell)		
		get_candidates(cell, :y)
	end

	def get_box_candidates(origin_cell)		
			get_candidates(origin_cell, :box)
	end

	def get_candidates(origin_cell,type)
		get_initial_candidates(origin_cell)
		 cells.each do |cell| 
		 		if cell.same_position_as?(origin_cell, type) && cell.filled_out?
		 			origin_cell.candidates.delete(cell.value)
		 		end		 		
		 end
	end

	def get_initial_candidates(origin_cell)
		# WFT MEANS N?!?!?!?
		(1..LENGTH).each {|n| origin_cell.candidates << n}  if origin_cell.candidates == []
	end


	def solve_cell(cell)
		update_candidates(cell)
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
	
