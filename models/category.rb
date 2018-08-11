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

  def update
    sql = 'UPDATE categories SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM categories WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = 'SELECT * FROM categories'
    SqlRunner
      .run(sql)
      .map { |category| Category.new(category) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM categories WHERE id = $1'
    result = SqlRunner.run(sql, [id])
    result.count.zero? ? nil : Category.new(result.first)
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM categories')
  end
end
