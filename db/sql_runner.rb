require 'pg'

class SqlRunner
  def self.run(sql, values = [])
    begin
      db = PG.connect(dbname: 'spending-tracker-4567')
      db.prepare('query', sql)
      db.exec_prepared('query', values)
    ensure
      db.close unless db.nil?
    end
  end
end
