FactoryBot.define do   
    factory :user, class: User do
        username        {"Test"}
        email           {"test@mail.it"}
        password        {"testtest"}
        role            {"U"}
        first_name      {"Test"}
        last_name       {"Test"}
    end
end