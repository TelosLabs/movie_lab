class Embedding
  def self.create(input)
    OpenAI::Client.new
      .embeddings(parameters: {model: "text-embedding-3-small", input:})
      .fetch("data")[0]["embedding"]
  end
end
