module Bang
  class RandomCodeGenerator
    SEEDS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

    def self.generator(length)
      Array.new(length) { SEEDS[rand(SEEDS.size)] }.join
    end
  end
end
