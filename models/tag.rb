require_relative '../db/sql_runner'

class Tag
  def initialize(options)
    @id = options['id'] if options['id']
    @category_id = options['category_id']
    @transaction_id = options['transaction_id']
  end

  def save
    sql = 'INSERT INTO tags (category_id, transaction_id)
           VALUES ($1, $2) RETURNING id'
    values = [@category_id, @transaction_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def self.all
    sql = 'SELECT * FROM tags'
    SqlRunner
      .run(sql)
      .map { |tag| Tag.new(tag) }
  end
end
