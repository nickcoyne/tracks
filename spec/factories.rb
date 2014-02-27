Factory.define :area do |f|
  f.sequence(:name) { |n| "Area#{ n }" }
  f.description 'The area description'
  f.association :region
end

Factory.define :nation do |f|
  f.sequence(:name) { |n| "Nation#{ n }" }
  f.description "Nation description"
end

Factory.define :region do |f|
  f.sequence(:name) { |n| "Region#{n}" }
  f.description "Region description"
  f.rain_readings 10
  f.association :nation
end

Factory.define :track do |f|
  f.sequence(:name) { |n| "Track#{n}" }
  f.desc_overview "An overview"
  f.association :area
end

Factory.define :user do |f|
  f.screen_name { Factory.next(:screen_nam) }
  f.login "Smith"
  f.password "qwerty"
end