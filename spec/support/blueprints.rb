require 'machinist/active_record'

User.blueprint do
  first_name { "Lionel" }
  last_name { "Messi" }
  email { "lionel#{sn}@nossascidades.org" }
  password { "123456" }
end

Event.blueprint do
  title { "Event #{sn}" }
  user  { User.make }
end
