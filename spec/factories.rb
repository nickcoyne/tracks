Factory.define :area do |f|
  f.sequence(:name) { |n| "Area#{ n }" }
  f.description 'The area description'
end

Factory.define :user do |f|
  f.screen_name { Factory.next(:screen_nam) }
  f.login "Smith"
  f.password "qwerty"
end