class RbHead
  def initialize(file_path, n = 10)
    @file_path = file_path
    @n = n
  end

  def run
    File.open(@file_path, 'r:bom|utf-8') do |file|
      lines = file.readlines.first(@n)
      lines.each do |line|
        line.chomp!  # Remove carriage returns and newlines from the end of each line
      end
    end
  end
end
