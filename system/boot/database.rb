ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    host:     'localhost',
    port:      5445,
    username: 'test',
    password: 'test',
    database: 'test'
  )