module SplitTestsAhoy
  class Alternative
    attr_reader :name, :percent

    def self.load_from_config(config)
      options = {}
      if config.is_a?(String)
        options[:name] = config
      else
        options = config
      end
      new(options)
    end

    def initialize(options = {})
      @name = options[:name]
      @percent = options[:percent]

      raise ArgumentError, "name is required" if @name.blank?
    end

    def weight
      percent / 100.0 if percent
    end
  end
end