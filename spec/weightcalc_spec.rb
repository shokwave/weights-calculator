require "weightcalc"

describe Weight do
  subject { Weight.new(20) }
  it { should respond_to :kg }
  it { should respond_to :lb }

  it "should return the correct weight in kg" do
    subject.kg.should be 20
  end

  it "should return the correct weight in lb" do
    subject.lb.should be_within(0.5).of(44)
  end
end
