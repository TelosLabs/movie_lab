class Embedding
  attr_reader :embedding

  def initialize(embedding)
    @embedding = embedding
  end

  def self.create(input)
    embedding = OpenAI::Client.new
      .embeddings(parameters: {model: "text-embedding-3-small", input:})
      .fetch("data")[0]["embedding"]
    new(embedding)
  end

  def to_s = embedding.to_s
end
