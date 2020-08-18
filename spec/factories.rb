FactoryBot.define do
  
    
    factory :user, class: User do
        username        {"ttt"}
        email           {"t@t.t"}
        password        {"tttttttt"}
        role            {"U"}
        first_name      {"ttt"}
        last_name       {"ttt"}
        #confirmed_at    {Time.now.utc}
    end
    


end