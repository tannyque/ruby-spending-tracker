require_relative '../db/sql_runner'

class User
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = 'INSERT INTO users (name) VALUES ($1) RETURNING id'
    @id = SqlRunner.run(sql, [@name]).first['id']
  end

  def self.all
    sql = 'SELECT * FROM users'
    SqlRunner
      .run(sql)
      .map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM users WHERE id = $1'
    user = SqlRunner.run(sql, [id])
    user.count.zero? ? nil : User.new(user.first)
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM users')
  end
end
