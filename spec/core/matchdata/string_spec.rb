require_relative '../../spec_helper'

describe "MatchData#string" do
  it "returns a copy of the match string" do
    str = /(.)(.)(\d+)(\d)/.match("THX1138.").string
    str.should == "THX1138."
  end

  it "returns a frozen copy of the match string" do
    str = /(.)(.)(\d+)(\d)/.match("THX1138.").string
    str.should == "THX1138."
    str.should.frozen?
  end

  it "returns the same frozen string for every call" do
    md = /(.)(.)(\d+)(\d)/.match("THX1138.")
    md.string.should equal(md.string)
  end

  # NATFIXME: Implement String#gsub
  xit "returns a frozen copy of the matched string for gsub(String)" do
    'he[[o'.gsub!('[', ']')
    $~.string.should == 'he[[o'
    $~.string.should.frozen?
  end
end
