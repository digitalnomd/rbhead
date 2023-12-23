class RbHead
  def initialize(file_path, n: nil, c: nil)
    @file_path = file_path
    @n = n
    @c = c
  end

  def run
    File.open(@file_path, 'r:bom|utf-8') do |file|

      if !@n.nil?
        lines = file.readlines.first(@n)
        lines.each do |line|
          line.chomp!  # Remove carriage returns and newlines from the end of each line
        end
      elsif !@c.nil?
        file.read(@c)
      else
        lines = file.readlines
        lines.each do |line|
          line.chomp!  # Remove carriage returns and newlines from the end of each line
        end
      end
    end
  end
end
