require_relative '../db/sql_runner'

class Category
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = 'INSERT INTO categories (name) VALUES ($1) RETURNING id'
    @id = SqlRunner.run(sql, [@name]).first['id']
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM categories')
  end
end
