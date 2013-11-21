class Cell

	def initialize
		@value = nil
		@candidates = []
		@position = {}
	end

	attr_reader :value , :candidates

	attr_accessor :position

  def value=(value)
    @value = value if value.between?(0,9)
  end

  def filled_out?
  	 @value != 0 && !@value.nil?
  end

  def candidates=(number)
  	@candidates << number if number.between?(1,9)

  end

  def remove_candidate(number)
  	@candidates.delete(number)
  end

  def solve
  	if @candidates.length == 1
  		@value = @candidates.first
  		@candidates = []
  	end
  end

end