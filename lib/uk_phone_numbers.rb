module UKPhoneNumbers
  # http://www.area-codes.org.uk/formatting.shtml#programmers
  PATTERNS = <<-PATTERNS
    (01###) #####[#]
    (011#) ### ####
    (01#1) ### ####
    (013873) #####
    (015242) #####
    (015394) #####
    (015395) #####
    (015396) #####
    (016973) #####
    (016974) #####
    (016977) ####[#]
    (017683) #####
    (017684) #####
    (017687) #####
    (019467) #####
    (02#) #### ####
    03## ### ####
    05### ######
    0500 ######
    07### ######
    08## ### ###[#]
    09## ### ####
  PATTERNS

  def self.pattern_to_regexp(pattern)
    regexp = pattern.dup
    regexp.gsub!(/[()]/, '')
    regexp = regexp.split.map { |p| "(#{p})" }.join
    regexp.gsub!(/\[([^\]]*)\]/, '(?:\1)?')
    regexp.gsub!(/#/, '\d')
    Regexp.new("^#{regexp}$")
  end

  REGEXPS = []
  # Convert each of the patterns to a regexp
  PATTERNS.split("\n").map(&:strip).each do |pattern|
    REGEXPS << pattern_to_regexp(pattern)
  end
  # Reverse-sort the regexps by how many digits they contain (their specificity)
  REGEXPS.sort_by! { |r| -r.source.scan(/\d/).length }

  def self.valid?(number)
    REGEXPS.select { |r| r.match(number) }.any?
  end

  def self.format(number, opts = {})
    match = REGEXPS.map { |r| r.match(number) }.reject(&:nil?).first
    match ? match[1..-1].join(opts[:separator] || ' ') : false
  end
end

