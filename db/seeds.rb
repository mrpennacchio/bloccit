require 'random_data'
# Create Users
5.times do
  User.create!(
  #
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all


#Create topics
15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end
topics = Topic.all


#Create Posts
50.times do
  # => using create! with a bang unstructs the method to alert us with an error if a
  #    problem occurs with the data we are seeding
    Post.create!(
      # => use methods from RandomData that creates random strings for title and body.
      user:  users.sample,
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
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# create an admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

# create a member
member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
