require "./lib/weightcalc.rb"

WEIGHT_SET = [
  6.8,
  5, 5,
  4.5,
  2.5, 2.5, 2.5, 2.5, 2.5, 2.5,
  2, 2,
  1, 1
]

weight_calc = WeightCalculator.new(WEIGHT_SET)

puts "How much do you want to lift?"
amount = gets.chomp.to_f
puts "You should rack:"
puts weight_calc.lift_kg(amount)
puts "on each side."
