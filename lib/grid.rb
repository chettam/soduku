require 'pry-byebug'

class Grid

		SIZE = 81
		MAXENUM = 10
		attr_reader :cells

	def initialize
		@cells =[]
		@solved = false

	end

	def solved?
		@cells.all? {|cell| cell.filled_out? }
	end

	def create(puzzle)
		@cells = []
		puzzle.chars.each_with_index do |number, index|
			@cells << Cell.new(number.to_i,index)
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
    grid =Grid.new
    grid.create(self.to_s)
    grid
  end

  def steal_solution(source)
    create(source.to_s)
    puts "creating"      
  end

  def plan_b
    blank_cell = @cells.reject(&:filled_out?).first
    puts blank_cell.candidates.count
    blank_cell.candidates.each do |candidate|
      blank_cell.assume(candidate)
      grid = replicate!
      grid.solve
      if grid.solved?
		    steal_solution(grid.to_s)
		    return true
	  	end
    end
    nil
  end

	def solve_cell(cell)
		update_candidates(cell)
		cell.solve!
	end

	def solve
		count = 0
		while !solved? && count <  SIZE * MAXENUM
			cell = next_cell
			if !cell.nil?
				solve_cell(cell)
			end
			count += 1
		end
		if !solved?
			puts "going to plan B"
		  plan_b
    	# binding.pry if r
		end
	end

	def to_s
		cells.map(&:value).join
	end
end
	
