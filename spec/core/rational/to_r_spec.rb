require_relative "../../spec_helper"
require_relative '../../shared/rational/to_r'

describe "Rational#to_r" do
  it_behaves_like :rational_to_r, :to_r

  it "raises TypeError trying to convert BasicObject" do
    obj = BasicObject.new
    -> { Rational(obj) }.should raise_error(TypeError)
  end

  it "works when a BasicObject has to_r" do
    obj = BasicObject.new; def obj.to_r; 1 / 2.to_r end
    # NATFIXME: Implement Rational(String)
    # Rational(obj).should == Rational('1/2')
    Rational(obj).should == Rational(1, 2)
  end

  it "fails when a BasicObject's to_r does not return a Rational" do
    obj = BasicObject.new; def obj.to_r; 1 end
    -> { Rational(obj) }.should raise_error(TypeError)
  end
end
