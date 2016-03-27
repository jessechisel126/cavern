module UploadHelper
  def self.average_list(a)
    sum = 0.0
    a.each do |element|
      sum += element
    end

    sum / a.length
  end

  def self.partition(a, num_partitions)
    num_points = a.length / num_partitions
    a.each_slice(num_points).to_a
  end
end
