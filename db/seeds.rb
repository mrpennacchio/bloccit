require 'random_data'

#Create topics
15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end
topics = Topic.all

100.times do
  SponsoredPost.create!(
  topic: topics.sample,
  title: "SPONSORED POST",
  body: RandomData.random_paragraph,
  price: $15
  )
end

sponsored_posts = SponsoredPost.all
#Create Posts
50.times do
  # => using create! with a bang unstructs the method to alert us with an error if a
  #    problem occurs with the data we are seeding
    Post.create!(
      # => use methods from RandomData that creates random strings for title and body.
      topic: topics.sample,
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

puts "Seed finished"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
