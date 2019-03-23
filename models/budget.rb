require_relative('../db/sql_runner')

class Budget
  attr_accessor :start_date, :end_date, :amount
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @start_date = options['start_date']
    @end_date = options['end_date']
    @amount = options['amount'].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run( sql )
  end

  def save()
    sql = "INSERT INTO budgets (start_date,end_date,amount) VALUES ($1,$2,$3) RETURNING id, start_date"
    values = [Date.today,@end_date,@amount]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    start_date = result.first['start_date']
    @id = id
    @start_date = start_date
  end

  def self.all
    sql = "SELECT * FROM budgets"
    return SqlRunner.run(sql).map{|hash| Budget.new(hash)}
  end

  def update
    sql = "UPDATE budgets SET (start_date,end_date,amount) = ($1,$2,$3) WHERE id = $4"
    values = [@start_date,@end_date,@name,@id]
    SqlRunner.run(sql,values)
  end

  def delete
    sql = "DELETE FROM budgets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end
end