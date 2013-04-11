# Set of weights, for a given number find the collection of weights that makes it up

class Plate
	attr_reader :kilos, :pounds

	def initialize weight
		@kilos = weight
		@pounds = (((2.204*weight)*2).round)/2.0
	end

	def to_s
		"#{@kilos} kg / #{@pounds} lbs"
	end

end

class Bar

	attr_reader :kilos, :pounds

	def initialize
		@kilos = (20/2.204)
		@pounds = 20
	end
end


Combination = Struct.new(:weights, :kg, :lb)

class WeightCalculator
	def initialize (weight_set)
		@set = all_combinations weight_set
	end

	def all_combinations (weight_set)
		weight_set.map! { |weight| Plate.new(weight) }
		
		arrangements = []
		(1..weight_set.length).each do |n|
			weight_set.combination(n).each do |foo|
				arrangements << Combination.new(foo, ((foo.reduce(0) { |acc, w| acc + w.kilos })*2 + 9.07), ((foo.reduce(0) { |acc, w| acc + w.pounds })*2 + 20))
			end
		end
		arrangements
	end

	def kg (desired_weight)
		diff = 1000
		@set.reduce do |lowest, weight|
			this_diff = (desired_weight - weight.kg).abs 
			if this_diff < diff
				diff = this_diff
				lowest = weight.weights
			end
			lowest
		end
	end

	def lbs
	end
end

weight_calc = WeightCalculator.new([
	6.8,
	5, 5,
	4.5,
	2.5, 2.5, 2.5, 2.5, 2.5, 2.5,
	2, 2,
	1, 1
	])

p weight_calc.kg 48
