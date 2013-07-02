require 'uk_phone_numbers'

describe UKPhoneNumbers do
  describe "::REGEXPS" do
    subject { UKPhoneNumbers::REGEXPS }
    it { should have(UKPhoneNumbers::PATTERNS.split("\n").length).items }
  end

  describe ".pattern_to_regexp" do
    def regexp_for(pattern)
      subject.pattern_to_regexp(pattern).source
    end

    it "given a String pattern returns a Regexp" do
      subject.pattern_to_regexp("0#").should be_a Regexp
    end

    it "strips parens from the pattern" do
      regexp_for("()").should_not include("()")
    end

    it "parenthesises whitespace-separated sections" do
      regexp_for("0 12 345").should include("(0)(12)(345)")
    end

    it "replaces # with \\d" do
      regexp_for("0#").should include("(0\\d)")
    end

    it "replaces bracketed expressions with optional non-capturing groups" do
      regexp_for("0[12]3[4]5").should include("(0(?:12)?3(?:4)?5)")
    end

    it "handles hashes inside brackets" do
      regexp_for("0[#]1[#]2").should include("(0(?:\\d)?1(?:\\d)?2)")
    end
  end

  describe ".valid?" do
    it "returns true for matching numbers" do
      subject.valid?('08456123123').should be_true
    end

    it "returns false for invalid numbers" do
      subject.valid?('08456123123123').should be_false
    end

    it "returns false for multiline strings containing a valid number" do
      subject.valid?("08456123123\nnotaphonenumber\n").should be_false
    end
  end

  describe ".format" do
    it "returns false for invalid numbers" do
      subject.format('08456123123123').should be_false
    end

    it "formats long-prefix numbers correctly" do
      subject.format('01946700000').should == '019467 00000'
    end

    it "formats mobile numbers correctly" do
      subject.format('07900000000').should == '07900 000000'
    end

    it "formats 08xx numbers correctly" do
      subject.format('08456123123').should == '0845 612 3123'
    end

    it "uses a custom separator when provided" do
      subject.format('08456123123', separator: '-').should == '0845-612-3123'
    end
  end
end

