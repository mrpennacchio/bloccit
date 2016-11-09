require 'random_data'

#Create Posts
50.times do
  # => using create! with a bang unstructs the method to alert us with an error if a
  #    problem occurs with the data we are seeding
    Post.create!(
      # => use methods from RandomData that creates random strings for title and body.
      title: RandomData.random_sentence,
      body:  RandomData.random_paragraph
    )
end
posts = Post.all

#Create Comments
# => call times on an Integer will run a given blcok the specified number of times
100.times do
  Comment.create!(
  # => call sample on the array returned by Post.all to pick a random post to associate each comment with
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end


100.times do
  Question.create!(
  # => call sample on the array returned by Post.all to pick a random post to associate each comment with
  title: RandomData.random_sentence,
  body:  RandomData.random_paragraph,
  resolved: false
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
