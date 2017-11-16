server '13.230.23.175', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/tsuna/.ssh/id_rsa'
