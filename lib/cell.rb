class Cell

  LENGTH = 9
  BOX_LENGTH = 3
  
	attr_reader :value , :candidates
	attr_accessor :position

	def initialize(value= nil,index = nil)
		@value = value
		@candidates = []
    initial_candidates
		@position = {}
    assign_position(index) unless index.nil?
	end

  def value=(value)
    @value = value if value.between?(0,9)
  end

  def filled_out?
  	 @value != 0 && !@value.nil?
  end

  def candidates=(number)
  	@candidates << number if number.between?(1,9) # else what? How do I know something happened? do I have to know?
  end

  def remove_candidate(number)
  	@candidates.delete(number)
  end

  def assume(value)
    @value = value
  end

  def solve!
  	@value = @candidates.delete(@candidates.first) if @candidates.length == 1
  end

  def same_position_as?(other, direction)
  	self.position[direction] == other.position[direction]
  end

  def initial_candidates

    (1..LENGTH).each {|n| candidates << n}  if candidates == []
  end

    def position_x(index)
    (index % LENGTH)
  end
  
  def position_y(index)
    (index / LENGTH)
  end

  def position_box(index)
    (position_x(index) / BOX_LENGTH ) + (position_y(index) / BOX_LENGTH ) * BOX_LENGTH
  end

  def assign_position(index)
      position[:x] = position_x(index)
      position[:y] = position_y(index)
      position[:box] = position_box(index)
  end

    def update_candidates(grid)
      horizontal_candidates_for(grid)
      vertical_candidates_for(grid)
      box_candidates_for(grid)
  end

  def horizontal_candidates_for(grid)   
    update_candidates_for(grid,:x)
  end

  def vertical_candidates_for(grid)
    update_candidates_for(grid,:y)
  end

  def box_candidates_for(grid) 
    update_candidates_for(grid,:box)
  end

  def update_candidates_for(grid,area)
     grid.cells.each do |cell| 
        if cell.same_position_as?(self, area) && cell.filled_out?
          self.remove_candidate(cell.value)
        end       
     end
  end

  def update(grid)
    self.update_candidates(grid)
    self.solve!
  end

end