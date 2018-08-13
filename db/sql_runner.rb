require 'pg'

class SqlRunner
  def self.run(sql, values = [])
    begin
      if ENV['RACK_ENV'] == 'production'
        db = PG.connect(
          dbname: 'dbv1bgpr44ld3j',
          host: 'ec2-54-221-210-97.compute-1.amazonaws.com',
          user: 'vdydvtyrhegmyf',
          port: '5432',
          password: 'fb640d0cff20a29918202762c9ece99739e338625bcb206f1384e00703e29115'
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
