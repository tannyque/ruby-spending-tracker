# In production will pull DB connection credentials from Rack environment
# variables, in development/test defaults to local connection.
module SqlRunner
  require 'pg'

  def self.run(sql, values = [])
    db = connect_to_db
    db.prepare('query', sql)
    db.exec_prepared('query', values)
  ensure
    db&.close
  end

  def self.connect_to_db
    ENV['RACK_ENV'] == 'production' ? connect_production : connect_local
  end

  def self.connect_local
    PG.connect(dbname: 'spending-tracker-4567')
  end

  def self.connect_production
    PG.connect(
      dbname: ENV['DB_NAME'],
      host: ENV['DB_HOST'],
      user: ENV['DB_USER'],
      port: ENV['DB_PORT'],
      password: ENV['DB_PASSWORD']
    )
  end
end
