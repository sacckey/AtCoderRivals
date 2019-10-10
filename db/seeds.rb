User.create!(user_name:  "Example User",
  uid: "12345",
  provider:  "twitter",
  image_url: "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg",
  atcoder_id: "chokudai")

99.times do |n|
user_name  = Faker::Name.name
provider = "twitter"
uid = "#{n+1}"
image_url = "https://pbs.twimg.com/profile_images/1066244463725445120/m-owVBJX_normal.jpg"
atcoder_id = "Yama24"
User.create!(user_name:  user_name,
  uid: uid,
  provider: provider,
  image_url: image_url,
  atcoder_id: atcoder_id)
end