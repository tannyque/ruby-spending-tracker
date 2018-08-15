require_relative '../db/sql_runner'

class Tag
  attr_reader :id, :category_id, :transaction_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @category_id = options['category_id'].to_i
    @transaction_id = options['transaction_id'].to_i
  end

  def save
    sql = 'INSERT INTO tags (category_id, transaction_id)
           VALUES ($1, $2) RETURNING id'
    values = [@category_id, @transaction_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def category
    sql = 'SELECT * FROM categories WHERE id = $1'
    values = [@category_id]
    result = SqlRunner.run(sql, values)
    result.count.zero? ? nil : Category.new(result.first)
  end

  def self.all
    sql = 'SELECT * FROM tags'
    SqlRunner
      .run(sql)
      .map { |tag| Tag.new(tag) }
  end

  def self.build_from_array(tags, transaction)
    tags.each do |pair|
      Tag.new(
        'transaction_id' => transaction.id,
        'category_id' => pair['id']
      ).save
    end
  end

  def self.by_transaction(id)
    sql = 'SELECT * FROM tags WHERE transaction_id = $1'
    SqlRunner
      .run(sql, [id])
      .map { |tag| Tag.new(tag) }
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM tags')
  end

  def ==(other)
    other.class == self.class &&
      other.category_id == category_id &&
      other.transaction_id == transaction_id
  end
end
