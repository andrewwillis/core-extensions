class Array
  def each_with_status(options = {}, &block)
    update_interval = options[:update_every] || 100
    start = Time.now
    each_with_index do |element,index|
      block.call(element)
      if index % update_interval == 0
        percent_complete = index.to_f/size # have to cast index so that percent_complete doesn't get forced to an int
        elapsed = Time.now - start
        if percent_complete == 0
          STDOUT.printf("Calculating completion time...")
        else
          total_estimate = elapsed / percent_complete
          STDOUT.printf("\r%d%% complete.  Estimated finish is %s", percent_complete * 100, (start + total_estimate).to_s)
        end
        STDOUT.flush
      end
    end
    STDOUT.printf("\n")
  end
end

