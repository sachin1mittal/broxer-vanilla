class Array
  #
  # Implement each with buffer
  # @param batch_size: 50 [type] [description]
  # @param sleep_duration: 0.1 [type] [description]
  #
  def buffer_each(batch_size: 50, sleep_duration: 0.1)
    self.each_slice(batch_size) do |slice|
      slice.each do |element|
        yield(element) if block_given?
      end
      sleep(sleep_duration)
    end
  end
end
