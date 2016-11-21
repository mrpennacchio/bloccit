# => define RandomData as a module because it is standalone with no dependencies or inheritance requirements
module RandomData
  # => sentences to an array, create 4-6 random sentences and put them on sentences

  def self.random_name
    first_name = random_word.capitalize
    last_name = random_word.capitalize
    "#{first_name} $#{last_name}"
  end

  def self.random_email
    "#{random_word}@#{random_word}.#{random_word}"
  end

  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end
    # => join on sentences conbines each sentences with a space between, making a paragraph
    sentences.join(" ")
  end

  # => random sentence. capitalize on it and append a period.
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  # => random word. an array of letters and call shuffle in place with a bang.
  # => join letters from the 0-3..8 and join them togeher to make a word.
  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end
end
