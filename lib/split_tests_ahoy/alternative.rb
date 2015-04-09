module SplitTestsAhoy
  class Alternative
    attr_reader :name, :percent

    def self.load_from_config(experiment, config)
      options = {experiment: experiment}
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
      @experiment = options[:experiment]

      raise ArgumentError, "name is required" if @name.blank?
    end

    def weight
      percent / 100.0 if percent
    end

    def participant_count
      @experiment.participants.for_alternative_name(@name).count
    end
  end
end