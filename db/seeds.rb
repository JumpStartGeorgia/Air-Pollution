# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
puts "=================================="


roles = %w(super_admin site_admin content_manager user)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# if this is not production
# and variable is set, create users if not exist
if ENV['create_user_accounts'].present? && !Rails.env.production?
  puts "LOADING TEST USER ACCOUNTS"
  User.find_or_create_by(email: 'super.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 1
  end

  User.find_or_create_by(email: 'site.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 2
  end

  User.find_or_create_by(email: 'content.manager@test.ge') do |u|
    puts "creating content manager"
    u.password = 'password123'
    u.role_id = 3
  end
end

# load test data if this is not production
if ENV['load_test_data'].present? && !Rails.env.production?

  puts 'DELETE EVERYTHING FIRST'
  Story.destroy_all
  Pledge.destroy_all
  Highlight.destroy_all

  stories = []
  pledges = []

  path = "#{Rails.root}/db/data/"

  puts 'CREATE STORIES'

  puts '- infographic1'
  s = Story.create(
    story_type: Story::TYPE[:infographic], is_public: true, posted_at: '2016-01-02', thumbnail: File.open(path + 'info1-thumb.jpg'),
    title_en: 'infographic 1', description_en: 'asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'info1.jpg')
  )
  s.datasources.create(name_en: 'CRRC', url_en: 'http://www.crrccenters.org/')
  s.datasources.create(name_en: 'GeoStat', url_en: 'http://google.com')
  stories << s

  puts '- infographic2'
  s = Story.create(
    story_type: Story::TYPE[:infographic], is_public: true, posted_at: '2016-05-04', thumbnail: File.open(path + 'info2-thumb.png'),
    title_en: 'infographic 2', description_en: 'werwer wer wer asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name2',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'info2.png')
  )
  stories << s


  puts '- infographic3'
  s = Story.create(
    story_type: Story::TYPE[:infographic], is_public: true, posted_at: '2015-01-02', thumbnail: File.open(path + 'info1-thumb.jpg'),
    title_en: 'infographic 3', description_en: 'asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name3',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'info1.jpg')
  )
  s.datasources.create(name_en: 'CRRC', url_en: 'http://www.crrccenters.org/')
  s.datasources.create(name_en: 'GeoStat', url_en: 'http://google.com')
  stories << s

  puts '- infographic4'
  s = Story.create(
    story_type: Story::TYPE[:infographic], is_public: true, posted_at: '2015-05-04', thumbnail: File.open(path + 'info2-thumb.png'),
    title_en: 'infographic 4', description_en: 'werwer wer wer asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er werwer wer wer asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er werwer wer wer asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name4',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'info2.png')
  )
  stories << s


  puts '- fact'
  s = Story.create(
      story_type: Story::TYPE[:fact], is_public: true, posted_at: '2016-06-20', thumbnail: File.open(path + 'fact1-thumb.jpg'),
      title_en: 'fact 1', description_en: 'asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Fact',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'fact1.jpg')
  )
  stories << s

  puts '- fact2'
  s = Story.create(
      story_type: Story::TYPE[:fact], is_public: true, posted_at: '2015-06-20', thumbnail: File.open(path + 'fact1-thumb.jpg'),
      title_en: 'fact 2', description_en: 'asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Fact',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'fact1.jpg')
  )
  stories << s


  puts '- gif'
  s = Story.create(
      story_type: Story::TYPE[:gif], is_public: true, posted_at: '2016-03-30', thumbnail: File.open(path + 'gif-thumb.gif'),
      title_en: 'gif 1', description_en: 'gif gif gif asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Gif',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'gif.gif')
  )
  stories << s

  puts '- gif'
  s = Story.create(
      story_type: Story::TYPE[:gif], is_public: true, posted_at: '2015-03-30', thumbnail: File.open(path + 'gif-thumb.gif'),
      title_en: 'gif 2', description_en: 'gif gif gif asdf alsdkjf alskdjf alsdkjf oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Gif',  url_en: 'https://feradi.info/en',
                                image: File.open(path + 'gif.gif')
  )
  stories << s


  puts '- sb'
  s = Story.create(
    story_type: Story::TYPE[:storybuilder], is_public: true, posted_at: '2015-05-02', thumbnail: File.open(path + 'sb-thumb.jpg'),
    title_en: 'sb 1', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name SB',  url_en: 'https://feradi.info/en',
                                embed_code_en: "<iframe src='http://storybuilder.jumpstart.ge/en/embed/bavshvebi-shavshvebidan?type=full' width='1000' height='100%' frameborder='0'></iframe>"
  )
  stories << s

  puts '- sb'
  s = Story.create(
    story_type: Story::TYPE[:storybuilder], is_public: true, posted_at: '2016-05-02', thumbnail: File.open(path + 'sb-thumb.jpg'),
    title_en: 'sb 2', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name SB2',  url_en: 'https://feradi.info/en',
                                embed_code_en: "<iframe src='http://storybuilder.jumpstart.ge/en/embed/bavshvebi-shavshvebidan?type=full' width='1000' height='100%' frameborder='0'></iframe>"
  )
  stories << s

  puts '- radio'
  s = Story.create(
    story_type: Story::TYPE[:radio], is_public: true, posted_at: '2016-11-02', thumbnail: File.open(path + 'radio-thumb.jpg'),
    title_en: 'radio 1', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Radio',  url_en: 'https://feradi.info/en',
                                embed_code_en: '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/292201337&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>'
  )
  stories << s

  puts '- radio'
  s = Story.create(
    story_type: Story::TYPE[:radio], is_public: true, posted_at: '2015-11-02', thumbnail: File.open(path + 'radio-thumb.jpg'),
    title_en: 'radio 2', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Radio',  url_en: 'https://feradi.info/en',
                                embed_code_en: '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/292201337&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>'
  )
  stories << s


  puts '- animation'
  s = Story.create(
    story_type: Story::TYPE[:animation], is_public: true, posted_at: '2016-02-22', thumbnail: File.open(path + 'animation-thumb.jpg'),
    title_en: 'animation 1', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Animation',  url_en: 'https://www.youtube.com/watch?v=zkP1u3ZRoeQ',
                                embed_code_en: '<iframe width="560" height="315" src="https://www.youtube.com/embed/zkP1u3ZRoeQ" frameborder="0" allowfullscreen></iframe>'
  )
  stories << s

  puts '- animation'
  s = Story.create(
    story_type: Story::TYPE[:animation], is_public: true, posted_at: '2015-02-22', thumbnail: File.open(path + 'animation-thumb.jpg'),
    title_en: 'animation 2', description_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
                                organization_en: 'Organization Name Animation',  url_en: 'https://www.youtube.com/watch?v=zkP1u3ZRoeQ',
                                embed_code_en: '<iframe width="560" height="315" src="https://www.youtube.com/embed/zkP1u3ZRoeQ" frameborder="0" allowfullscreen></iframe>'
  )
  stories << s




  puts '-------------------'

  puts 'CREATE PLEDGES'

  p = Pledge.create(
    is_public: true, posted_at: '2015-02-22', image: File.open(path + 'pledge1.jpg'),
    title_en: 'Pledge 1', 
    why_care_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
    what_it_is_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er',
    what_you_do: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er'
  )
  pledges << p

  p = Pledge.create(
    is_public: true, posted_at: '2016-04-22', image: File.open(path + 'pledge2.jpg'),
    title_en: 'Pledge 2', 
    why_care_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
    what_it_is_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er' ,
    what_you_do: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er'
  )
  pledges << p


  p = Pledge.create(
    is_public: true, posted_at: '2015-04-22', image: File.open(path + 'pledge3.jpg'),
    title_en: 'Pledge Pledge 3', 
    why_care_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
    what_it_is_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er',
    what_you_do: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er'
  )
  pledges << p

  p = Pledge.create(
    is_public: true, posted_at: '2016-06-22', image: File.open(path + 'pledge4.jpg'),
    title_en: 'Pledge Pledge 4', 
    why_care_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er', 
    what_it_is_en: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er',
    what_you_do: 'lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er lka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu erlka sdflkjas dflkwje rlmnz,xmncv aksnd fkasnf lwker lwkejr f oiwe roiwue rowu er'
  )
  pledges << p



  puts '-------------------'

  puts 'CREATE HIGHLIGHTS'

  item = stories.sample

  h = Highlight.create(
    is_public: true, posted_at: '2015-02-22',
    title_en: item.title, url_en: 'http://jumpstart.ge',
                                image: File.open(path + 'highlight1.jpg')
  )
  
  item = stories.sample

  h = Highlight.create(
    is_public: true, posted_at: '2016-02-22',
    title_en: item.title, url_en: 'http://jumpstart.ge',
                                image: File.open(path + 'highlight2.jpg')
  )
  
  item = pledges.sample

  h = Highlight.create(
    is_public: true, posted_at: '2015-08-22',
    title_en: item.title, url_en: 'http://jumpstart.ge',
                                image: File.open(path + 'highlight3.jpg')
  )
  
  item = pledges.sample

  h = Highlight.create(
    is_public: true, posted_at: '2016-08-22',
    title_en: item.title, url_en: 'http://jumpstart.ge',
                                image: File.open(path + 'highlight4.jpg')
  )
  

end

