class Rating
  attr_reader :data, :data_read_at

  def self.data
    model_path = Rails.root.join("tmp/model")
    if !@data || !@data_read_at < File.updated_at(model_path)
      @data = Marshal.load(model_path)
      @data_read_at = Time.current
    end

@data
  end
end
