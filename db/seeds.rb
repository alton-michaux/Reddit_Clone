# frozen_string_literal: true

account_1 = Account.create(first_name: 'Roscoe', last_name: 'Jenkins', username: 'Joscoe31', password: 'password',
                           bio: 'You only regret your regrets.', email: 'RosJen@job.com')
account_2 = Account.create(first_name: 'Jillian', last_name: 'Hinrech', username: 'JillyBeans', password: 'password',
                           bio: "I don't come here often", email: 'homegrown20@yahoo.com')
account_3 = Account.create(first_name: 'Finias', last_name: 'Zucchini', username: 'FucchiniOO', password: 'password',
                           bio: "You can't fake zucchini", email: 'ObsessedWithVeggies@weirdfolk.com')
account_4 = Account.create(first_name: 'Farrah', last_name: 'Jackson', username: 'TewCute36', password: 'password',
                           bio: 'I literally come here everyday', email: 'all_day_bae@generic.com')

puts "#{Account.count} accounts created"

community_1 = Community.create(name: 'Random Quotes', account_id: account_1.id,
                               url: 'http://www.silly-reddit.com/random_quotes', total_members: 0, rules: 'No fighting. No biting', summary: 'A place where random folks can enjoy random quotes.')
community_2 = Community.create(name: 'Nature Stuff', account_id: account_2.id,
                               url: 'http://www.silly-reddit.com/nature_stuff', total_members: 0, rules: 'Respect nature at all costs!', summary: 'Come join us in nature.')
community_3 = Community.create(name: 'Dark Humor', account_id: account_3.id,
                               url: 'http://www.silly-reddit.com/dark_humor', total_members: 0, rules: 'Memes will be downvoted immediately', summary: 'Lets laugh while we cry')
community_4 = Community.create(name: 'Beautifully Me', account_id: account_4.id,
                               url: 'http://www.silly-reddit.com/beautifully_me', total_members: 0, rules: 'Be nice and respectful', summary: 'We can all celebrate our uniqueness together!')

puts "#{Community.count} communities created"

Subscription.create(account_id: account_1.id, community_id: community_1.id)
Subscription.create(account_id: account_2.id, community_id: community_2.id)
Subscription.create(account_id: account_3.id, community_id: community_3.id)
Subscription.create(account_id: account_4.id, community_id: community_4.id)

puts "#{Subscription.count} subscriptions created"

Post.create(account_id: account_1.id, community_id: community_1.id, title: 'Dragons are real', body: 'One ate my sandwich yesterday and he keeps coming back to my house to mock me about it',
            total_comments: 0)
Post.create(account_id: account_2.id, community_id: community_2.id, title: 'Do not envy the butterfly', body: 'One ate my sandwich yesterday and he keeps coming back to my house to mock me about it',
            total_comments: 0)
Post.create(account_id: account_3.id, community_id: community_3.id, title: "I really don't see myself buying anything from Walmart", body: "I'd rather not get shot today", total_comments: 0)
Post.create(account_id: account_4.id, community_id: community_4.id, title: 'Welcome Everyone~', body: 'Show love to one another and enjoy the day!', total_comments: 0)

puts "#{Post.count} posts created"
