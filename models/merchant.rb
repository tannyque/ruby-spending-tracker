require_relative '../db/sql_runner'

class Merchant
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = 'INSERT INTO merchants (name) VALUES ($1) RETURNING id'
    @id = SqlRunner.run(sql, [@name]).first['id']
  end

  def update
    sql = 'UPDATE merchants SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM merchants WHERE id = $1'
    SqlRunner.run(sql, [@id])
  end

  def self.all
    sql = 'SELECT * FROM merchants'
    SqlRunner
      .run(sql)
      .map { |merchant| Merchant.new(merchant) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM merchants WHERE id = $1'
    result = SqlRunner.run(sql, [id])
    result.count.zero? ? nil : Merchant.new(result.first)
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM merchants')
  end
end
