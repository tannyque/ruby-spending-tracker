require_relative '../db/sql_runner'

class Transaction
  attr_reader :id, :amount, :user_id, :merchant_id

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

  def self.all
    sql = 'SELECT * FROM transactions'
    SqlRunner
      .run(sql)
      .map { |transaction| Transaction.new(transaction) }
  end
end
