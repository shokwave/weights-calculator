# Set of weights, for a given number find the collection of weights that makes it up

class Weight
  def initialize(weight)
    @weight = weight
  end

  def kg
    @weight
  end

  def lb
    (@weight * 2.204 * 2).round / 2.0
  end

	def to_s
		"#{kg} kg / #{lb} lbs"
	end
end

class Plate < Weight
	def initialize(weight)
    super weight
	end
end

class Bar < Weight
	def initialize
    super 9
	end
end

class WeightCalculator
  attr_reader :combinations

  def initialize(weight_set)
    plates = weight_set.map { |weight| Plate.new(weight) }
    @bar = Bar.new
    @combinations = generate_combinations(plates)
  end

  def generate_combinations(plates)
    combinations = Hash.new
    (0..plates.length).each do |n|
      plates.combination(n).each do |poundage|
        total = poundage.reduce(0) { |acc, plate| plate.kg + acc }
        combo = combinations.fetch(total) do 
          combinations[total] = poundage
        end
        prev_plates = combo
        combinations[total] = poundage if poundage.length < prev_plates.length
      end
    end
    combinations
  end

  def lift_kg(amount)
    poundage = (amount - @bar.kg) / 2.0
    combinations[poundage]
  end
end
