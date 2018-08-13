require 'pg'

class SqlRunner
  def self.run(sql, values = [])
    begin
      if ENV['RACK_ENV'] == 'production'
        db = PG.connect(
          dbname: 'spending-tracker-4567',
          host: ENV['DATABASE_URL']
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
