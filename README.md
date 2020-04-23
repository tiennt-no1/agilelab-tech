# Welcome to Agile Lab!

This is our technical test. Once you are done, you can either upload the answers to your own repository and share us the link, or you can zip your answers up and send it directly to us via email!

Enjoy!

## 1. Anagram Tester

An anagram is created by re-arranging the letters of a word. For example, the word `LISTEN` is an anagram of `SILENT`.
You can find the definition in [Wikipedia](https://en.wikipedia.org/wiki/Anagram).
Below is a skeleton defenition of a method for testing if two words make an anagram. Your task is to implement this
method, using Ruby. It should take in two strings and return `true` if the two words make an anagram, or `false` if it's not.

```ruby
def anagram?(first_word, second_word)
  # Add your implementation here
end
# the example is include on test.rb file
```

**Rules:**
 - You don't need to care about upper- and lowercase letters. That is, `A` and `a` can be considered the same for the purposes of this test.
 - You only need to care about single words. The method does not need to handle sentences.
 
 

### Anwser: 

```ruby
def anagram?(first_word, second_word)
    first_word.gsub(' ', '').downcase.each_char.sort == second_word.gsub(' ', '').downcase.each_char.sort
end
# the example is include on test.rb file
```

## 2. Anonymous Chat

You are tasked to create a Anonymous Chat where public is able to initiate a anonymous conversation with the admin

You are to only required to create the `routes.rb` that can fulfil all the requirements listed below.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Add your routes for Anonymous Chat
end

```

**Requirements:**
 - Public can initiate the chat
 - Admin can acknowledge that they have seen the chat (not messages).
 - Admin can response to the chat with the person who initiate the chat.
 - Admin can closed the conversation.
 - Admin cannot initiate the chat.

### Answer:
```ruby
# config/routes.rb
Rails.application.routes.draw do

  get 'anonymous_chat/index' #this is single index page
  root to: 'anonymous_chat#index'
  mount ActionCable.server => '/anonymous_chat' # using action cable to chat between admin and anonymous user

  # the route to login/logout for admin
  post "/login"
  delete "/logout"

  scope "/anonymous_chat" do
    #admin can view list of chat room(conversation) or end conversation
    # public user can create new conversation
    # the authentication and authorization will be integrated on controller
    resources :rooms, only: %i(create delete index) do 
      # to show list of message based on room id, ... mark that Admin have seen the chat (not messages).
      # admin/user chatting by create new message then streaming to specific chanel using action cable
      resource :messages, only: %i(index create)
    end
  end
  
end

```


## 3. Bug Fixing

When client or users reported an issue to you, describe what you do next.
How do you go about trouble shooting the issue? Depending on what you find, what will your next step be? When do you
consider the issue fixed or resolved?

**Tips:**
- You are free to make **ANY** assumptions, write down your assumptions.


### Answer:
When the client or users reported an issue to me, first, I will check all logging or exception catching system like the rails log, Sentry or Airbrake,  we should monitor it regularly. Then we can easily find the leaf cause like which line is an error, why it error, what situation, ... and fixed it quickly. I will try to make the system work normal as soon as possible because the received report from the client is an urgent situation. Sometimes fix, sometimes find a way to work around and cover this issue. Other, collect all information from the customer is important, It is good to reproduce this issue end to end. It will help resolve the issue if the first step doesn't have anything to investigate. 
After the system is stable, this time to investigate more to resolve the root problem. Remember try to write/add more test case for this situation and continue tracking to make sure this issue don't happen again. The issue is considered fixed if we know the root cause and make sure it does not happen again in the same/similar situation.

For example on a recent project, I met one case is the oauth2 system is not working when integrating the Single Sign-In system. After received this bug I check on Airbrake and find nothing. The first step I do is revert to the previous version to make sure everything is work ok. Then I get all info from clients like client account detail. Then check each step on login, the issue is Single Sign-In system not use session token to authorize like it used to, it use user_id is store on the cookie. Then I fixed this line, add tracking log and catch exception to this block. Write the test case to make sure it works before redeploy on staging/UAT server to manual test again, and deploy to production. The issue is considered fixed if we know the root cause and make sure it does not happen again in the same/similar situation.  

## 4. Taking over an old project

You have recently been assigned to an old project, the previous developer had already left and you are tasked to take over the project and implement new features.
However you are facing some problems, the new feature that you are implementating doesn't seem to go well with the existing features.
The more you code, the more edge case you encounter.

Describe, in as much detail as you like, how you would handle this situation.

**Tips:**
- You are free to make **ANY** assumptions, write down your assumptions.


### Anwser: 

It is good if I have a clear document from the previous developer. I will follow this document and combine it with the source code to understand what the system is doing. What is the input, output of each function, API, module, service ... In my opinion, it is a bad developer who integrates a new feature if not understanding how existing feature works. Because the application is a system, each feature related to others. Build a new feature when not understand the system is a thing like go to work but doesn't know what you are doing. I think the solution is to stop integrate new features, and investigate more time to the system, the existed feature. Just make it clear first when starting a new feature. If a small project, no problem here, just spend a little time. If it's a big project, a developer should understand everything from the general structure to details and have a responsibility for any change. I think when developing a project, the goal is to make it work and make it work better like reduce latency, increase performance. It's not to do something similar to existed feature so it's important to understand the system clearly. Besides, write clean code is important for a good developer, it help writer and who read him code easy to understand the business logic.

For example, one old project I used to work is about Foreign Exchange when I worked for IP Coins. We use Ruby on Rails, rabbitMQ, Kaffka, Redis, mutual service,... In the beginning, I cannot understand the system because This project doesn't have any document and all members of the previous team resigned. And I cannot understand like the monolithic app. Many services run on consumers of Kafka. Then my team spends about 1 month understanding the structure of the system by drawing a big picture of the structure, go to details to each part, try to understand each existed test case. The system is gradually clearer, we can understand. For me, I investigate more time to evaluate the existed code, which part is not good, and try to refactor it. Luckily, the previous team build the test system so we can check the app still work as well after I refactor. After that, I understand the system clearly and easy to integrate new features or fixing bugs from existed features.