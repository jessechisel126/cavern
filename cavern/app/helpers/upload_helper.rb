include WaveFile

module UploadHelper

	def read_file(file_name)
		reader = Reader.new(file_name)
		begin
			while true do
				buffer = reader.read(4096)
				puts "Read #{buffer.samples.length} samples."
			end
		rescue EOFError
			reader.close
		end
	end

end
