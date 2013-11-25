class Cell

	attr_reader :value , :candidates
	attr_accessor :position

	def initialize(value= nil)
		@value = value
		@candidates = []
    initial_candidates
		@position = {}
	end

  def value=(value)
    @value = value if value.between?(0,9)
  end

  def filled_out?
  	 value != 0 && !value.nil?
  end

  def candidates=(number)
  	candidates << number if number.between?(1,9) # else what? How do I know something happened? do I have to know?
  end

  def remove_candidate(number)
  	candidates.delete(number)
  end

  def solve!
  	@value = candidates.shift if candidates.length == 1
  end

  def same_position_as?(other, direction)
  	self.position[direction] == other.position[direction]
  end

    def initial_candidates
    (1..Grid::LENGTH).each {|n| @candidates << n}
  end

end