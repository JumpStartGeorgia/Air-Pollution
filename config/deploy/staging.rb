set :domain, 'alpha.jumpstart.ge'
set :user, 'filter-staging'
set :application, 'Filter-Staging'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/JumpStartGeorgia/Air-Pollution.git'
set :branch, 'master'
set :web_url, 'dev-filter.jumpstart.ge'
set :visible_to_robots, false
set :use_ssl, true
set :puma_worker_count, '2'
set :puma_thread_count_min, '1'
set :puma_thread_count_max, '8'
