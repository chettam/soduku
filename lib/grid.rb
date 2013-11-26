class Grid

		SIZE = 81
		MAXENUM = 10
		attr_reader :cells

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

  def replicate!
    grid =Grid.new
    grid.create(self.to_s)
    grid
  end

  def apply_solution_to_grid(source)
    create(source.to_s)     
  end

  def plan_b
    blank_cell = @cells.reject(&:filled_out?).first
    blank_cell.candidates.each do |candidate|
      blank_cell.assume(candidate)
      grid = replicate!
      grid.solve
      if grid.solved?
		    apply_solution_to_grid(grid.to_s)
		    return
	  	end
    end

  end

	def solve
		count = 0
		while !solved? && count <  SIZE * MAXENUM
			cell = next_cell
			if !cell.nil?
				cell.update(self)
			end
			count += 1
		end
		if !solved?
		  plan_b
		end
	end

	def to_s
		cells.map(&:value).join
	end
end
	
