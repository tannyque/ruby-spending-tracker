require_relative '../db/sql_runner'

class Transaction
  attr_reader :id, :amount, :merchant_id
  attr_accessor :user_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @user_id = options['user_id'].to_i
    @merchant_id = options['merchant_id'].to_i
  end

  def save
    sql = 'INSERT INTO transactions (amount, user_id, merchant_id)
           VALUES ($1, $2, $3) RETURNING id'
    values = [@amount, @user_id, @merchant_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update
    sql = 'UPDATE transactions SET (amount, user_id, merchant_id) =
          ($1, $2, $3) WHERE id = $4'
    values = [@amount, @user_id, @merchant_id, @id]
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

  def user
    sql = 'SELECT * FROM users WHERE id = $1'
    result = SqlRunner.run(sql, [@user_id])
    User.new(result.first)
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
