FactoryBot.define do
  
    
    factory :user, class: User do
        username        {"fff"}
        email           {"f@f.f"}
        password        {"ffffffff"}
        role            {"U"}
        first_name      {"fff"}
        last_name       {"fff"}
        
        

    end

    factory :recipe1, class: Recipe do
        user_id         {1}
        title           {'Recipe1'} 
        preparazione    {'Preparation1'}
        image           {'./support/test_image.jpg'}
        n_likes         {0}
        n_comments      {0}
        created_at      {Time.now.utc}
    end
    


end