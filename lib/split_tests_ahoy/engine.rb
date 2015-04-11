module SplitTestsAhoy
  class Engine < ::Rails::Engine
    isolate_namespace SplitTestsAhoy

    config.autoload_paths += [File.expand_path("../", __FILE__)]
  end
end
