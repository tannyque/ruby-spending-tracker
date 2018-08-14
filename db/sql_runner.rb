require 'pg'

# In production will pull DB connection credentials from Rack environment
# variables, in development/test defaults to local connection.
class SqlRunner
  def self.run(sql, values = [])
    db = ENV['RACK_ENV'] == 'production' ? connect_production : connect_local
    db.prepare('query', sql)
    db.exec_prepared('query', values)
  ensure
    db&.close
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
