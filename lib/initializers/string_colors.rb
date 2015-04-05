# Add colorization methods to String
class String
  def colorize!(color_code); self.replace "\e[#{color_code}m#{self}\e[0m"; end
  def red!;    colorize!(31); end
  def green!;  colorize!(32); end
  def yellow!; colorize!(33); end
  def blue!;   colorize!(36); end
end
