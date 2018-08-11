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

  def self.all
    sql = 'SELECT * FROM merchants'
    SqlRunner
      .run(sql)
      .map { |merchant| Merchant.new(merchant) }
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM merchants')
  end
end
