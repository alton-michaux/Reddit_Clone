# frozen_string_literal: true

Account.create('first_name' => 'Will', 'last_name' => 'Beto', 'username' => 'willieB23',
               'bio' => 'I am the orginal. All comes after me. Also, tuna sandwiches.', 'email' => 'horace@jupiter.com')
Community.create('account_id' => 1, 'name' => 'Paddle_Golf', 'url' => 'www.paddle_golf.com', 'total_members' => nil,
                 'rules' => 'Be awesome.')
Community.create('account_id' => 1, 'name' => 'WebDev', 'url' => 'www.webdev.com', 'total_members' => nil,
                 'rules' => "No spam.\r\nBe respectful.")
Community.create('account_id' => 1, 'name' => 'Target Employees', 'url' => 'www.targetworkers.com', 'total_members' => nil,
                 'rules' => "Must work at target.\r\nDon't be lazy.\r\nDon't touch my damn tugger!")
Community.create('account_id' => 1, 'name' => 'Music Junkies', 'url' => 'www.spotify.com', 'total_members' => nil,
                 'rules' => "Must love music.\r\nDon't be judgemental.")
Post.create('account_id' => 1, 'community_id' => 1, 'title' => 'New post!', 'body' => 'Hooray!', 'upvotes' => 0, 'downvotes' => 0,
            'total_comments' => 0)
Post.create('account_id' => 1, 'community_id' => 3, 'title' => 'Working at Target',
            'body' => "I know people complain a lot, but it's really a pretty good job.", 'upvotes' => 0, 'downvotes' => 0, 'total_comments' => 0)
Post.create('account_id' => 1, 'community_id' => 4, 'title' => 'Old heads suck...',
            'body' => "I don't get why old folks complain about today's music. Seriously, what is it?", 'upvotes' => 0, 'downvotes' => 0, 'total_comments' => 0)
Post.create('account_id' => 1, 'community_id' => 4, 'title' => 'Old vinyls', 'body' => 'We should bring them back!',
            'upvotes' => 0, 'downvotes' => 0, 'total_comments' => 0)
Post.create('account_id' => 1, 'community_id' => 2, 'title' => 'My journey',
            'body' => "It's about to be a year since I've started preparing for a career as a WebDev and I couldn't be happier with my decision!", 'upvotes' => 0, 'downvotes' => 0, 'total_comments' => 0)
