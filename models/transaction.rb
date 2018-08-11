require_relative '../db/sql_runner'

class Transaction
  attr_reader :id, :amount, :user_id, :merchant_id

  def initialize(options)
    @id = options['id'] if options['id']
    @amount = options['amount']
    @user_id = options['user_id']
    @merchant_id = options['merchant_id']
  end

  def save
    sql = 'INSERT INTO transactions (amount, user_id, merchant_id)
           VALUES ($1, $2, $3) RETURNING id'
    values = [@amount, @user_id, @merchant_id]
    @id = SqlRunner.run(sql, values).first['id']
  end
end
