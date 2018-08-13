require_relative '../db/sql_runner'

class Merchant
  attr_reader :id, :name, :image

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].downcase
    @image = options['image']
  end

  def save
    sql = 'INSERT INTO merchants (name, image) VALUES ($1, $2) RETURNING id'
    @id = SqlRunner.run(sql, [@name, @image]).first['id']
  end

  def update
    sql = 'UPDATE merchants SET (name, image) = ($1, $2) WHERE id = $3'
    values = [@name, @image, @id]
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
