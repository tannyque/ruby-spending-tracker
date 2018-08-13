require_relative '../db/sql_runner'
require_relative 'transaction'

class User
  attr_reader :id, :name, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].downcase
    @budget = options['budget'].to_i
  end

  def save
    sql = 'INSERT INTO users (name, budget) VALUES ($1, $2) RETURNING id'
    @id = SqlRunner.run(sql, [@name, @budget]).first['id']
  end

  def transactions
    sql = 'SELECT * FROM transactions WHERE user_id = $1'
    values = [@id]
    SqlRunner
      .run(sql, values)
      .map { |transaction| Transaction.new(transaction) }
  end

  def transaction_value
    transactions.sum(&:amount)
  end

  def balance
    @budget - transaction_value
  end

  def self.all
    sql = 'SELECT * FROM users'
    SqlRunner
      .run(sql)
      .map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM users WHERE id = $1'
    user = SqlRunner.run(sql, [id])
    user.count.zero? ? nil : User.new(user.first)
  end

  def self.delete_all
    SqlRunner.run('DELETE FROM users')
  end
end
