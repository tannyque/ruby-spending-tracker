require_relative '../db/sql_runner'

class Transaction
  attr_reader :id, :amount, :merchant_id
  attr_accessor :user_id, :created_at

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @user_id = options['user_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @created_at = Time.parse(options['created_at']) if options['created_at']
  end

  def save
    sql = 'INSERT INTO transactions (amount, user_id, merchant_id, created_at)
           VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@amount, @user_id, @merchant_id, @created_at]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update
    sql = 'UPDATE transactions SET (amount, user_id, merchant_id, created_at) =
          ($1, $2, $3, $4) WHERE id = $5'
    values = [@amount, @user_id, @merchant_id, @created_at, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    SqlRunner.run('DELETE FROM transactions WHERE id = $1', [@id])
  end

  def merchant
    sql = 'SELECT * FROM merchants WHERE id = $1'
    result = SqlRunner.run(sql, [@merchant_id])
    Merchant.new(result.first)
  end

  def categories
    tags.map { |tag| Category.find_by_id(tag.category_id) }
  end

  def tags
    sql = 'SELECT * FROM tags WHERE transaction_id = $1'
    SqlRunner
      .run(sql, [@id])
      .map { |tag| Tag.new(tag) }
  end

  def user
    sql = 'SELECT * FROM users WHERE id = $1'
    result = SqlRunner.run(sql, [@user_id])
    User.new(result.first)
  end

  def category?(category)
    categories.include?(category)
  end

  def pretty_date
    @created_at.strftime('%a %e %b %Y at %H:%M')
  end

  def delete_all_tags
    sql = 'DELETE FROM tags WHERE transaction_id = $1'
    SqlRunner.run(sql, [@id])
  end

  def self.all
    sql = 'SELECT * FROM transactions'
    SqlRunner
      .run(sql)
      .map { |transaction| Transaction.new(transaction) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM transactions WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    result.count.zero? ? nil : Transaction.new(result.first)
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM transactions')
  end
end
