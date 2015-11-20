module Morse
  @ascii_to_morse = {
    'a' => '·−',
    'b' => '−···',
    'c' => '−·−·',
    'd' => '−··',
    'e' => '·',
    'f' => '··−·',
    'g' => '−−·',
    'h' => '····',
    'i' => '··',
    'j' => '·−−−',
    'k' => '−·−',
    'l' => '·−··',
    'm' => '−−',
    'n' => '−·',
    'o' => '−−−',
    'p' => '·−−·',
    'q' => '−−·−',
    'r' => '·−·',
    's' => '···',
    't' => '−',
    'u' => '··−',
    'v' => '···−',
    'w' => '·−−',
    'x' => '−··−',
    'y' => '−·−−',
    'z' => '−−··',
    '1' => '·−−−−',
    '2' => '··−−−',
    '3' => '···−−',
    '4' => '····−',
    '5' => '·····',
    '6' => '−····',
    '7' => '−−···',
    '8' => '−−−··',
    '9' => '−−−−·',
    '0' => '−−−−−',
    '.' => '·−·−·−',
    ',' => '−−··−−',
    '?' => '··−−··',
    "'" => '·−−−−·',
    '!' => '−·−·−−',
    '/' => '−··−·',
    '(' => '−·−−·',
    ')' => '−·−−·−',
    '&' => '·−···',
    ':' => '−−−···',
    ';' => '−·−·−·',
    '=' => '−···−',
    '+' => '·−·−·',
    '-' => '−····−',
    '_' => '··−−·−',
    '"' => '·−··−·',
    '$' => '···−··−',
    '@' => '·−−·−·',
    '·' => '\·', # Escape dot-literal so this file can encode itself. Otherwise codes to 'e'
    '−' => '\−'  # Ditto with dash-literal and 't'
  }

  @morse_to_troll = {
    '·' => ':troll:',
    '−' => ':troll_long:'
  }

  @morse_to_ascci = @ascii_to_morse.invert
  @troll_to_morse = @morse_to_troll.invert


  def self.to_morse(str)
    sanitized = str.
      downcase.
      gsub('“', '"').
      gsub('”', '"').
      gsub('’', "'")

    sanitized.
      chars.
      map{|c| @ascii_to_morse.fetch(c, c) }.
      join(' ')
  end

  def self.to_troll_morse(str)
    to_morse(str).gsub(/./) {|c| @morse_to_troll.fetch(c, c) }
  end

  def self.from_morse(morse)
    morse.split('   ').
      map{|word| word.split(/ /).map{|code| @morse_to_ascci.fetch(code, code) }.join }.
      join(' ')
  end

  def self.from_troll_morse(troll)
    from_morse troll.gsub(/:.*?:/, @troll_to_morse)
  end

end
