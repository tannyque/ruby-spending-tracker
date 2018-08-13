require 'pg'

class SqlRunner
  def self.run(sql, values = [])
    begin
      if ENV['RACK_ENV'] == 'production'
        db = PG.connect(
          dbname: ENV['DB_NAME'],
          host: ENV['DB_HOST'],
          user: ENV['DB_USER'],
          port: ENV['DB_PORT'],
          password: ENV['DB_PASSWORD']
        )
      else
        db = PG.connect(dbname: 'spending-tracker-4567')
      end
      db.prepare('query', sql)
      db.exec_prepared('query', values)
    ensure
      db.close unless db.nil?
    end
  end
end
