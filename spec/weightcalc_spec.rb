require "weightcalc"

FIXTURE_WEIGHT_SET = [
  6.8,
  5, 5,
  4.5,
  2.5, 2.5, 2.5, 2.5, 2.5, 2.5,
  2, 2,
  1, 1
]

describe Weight do
  subject { Weight.new(20) }

  it { should respond_to :kg }
  it { should respond_to :lb }

  it "should return the correct weight in kg" do
    subject.kg.should == 20
  end

  it "should return the correct weight in lb" do
    subject.lb.should be_within(0.5).of(44)
  end
end

describe Plate do
  subject { Plate.new(20) }

  it { should respond_to :kg }
  it { should respond_to :lb }
  its(:kg) { should == 20 }
end

describe Bar do
  subject { Bar.new }

  its(:kg) { should == 9 }
end

describe WeightCalculator do
  subject { WeightCalculator.new(FIXTURE_WEIGHT_SET) }
  it { should respond_to :combinations }

  it "should have the right number of combinations" do
    subject.combinations.length.should == 148
  end

  it "should have the empty combination" do
    subject.combinations.should have_key 0
  end

  it "should have the empty combination" do
    subject.combinations.should have_key FIXTURE_WEIGHT_SET.inject(:+)
  end

  it "should get the best result!" do
    poundage = subject.combinations[19.5]
    poundage.should_not be_nil
    poundage.length.should == 5
  end

  describe "calculating plates" do
    it { should respond_to :lift_kg }

    it "should give the correct plates" do
      plates = subject.lift_kg(48)
      plates.length.should == 5
      plates.reduce(0) { |acc, plate| acc + plate.kg }.should == 19.5
    end
  end
end
