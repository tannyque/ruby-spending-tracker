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
end
