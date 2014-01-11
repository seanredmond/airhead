module Hydra
  module Erbable
    def load_erb(tdir, file)
      ERB.new(
        File.read(File.join(tdir, file))
      )
    end
  end
end
