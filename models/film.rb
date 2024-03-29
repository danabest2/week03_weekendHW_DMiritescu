require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price



  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
      sql = "INSERT INTO films(title, price)
            VALUES ($1, $2)
            RETURNING id"
      values = [@title, @price]
      film = SqlRunner.run(sql, values).first
      @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map{ |film|  Film.new(film) }
    return result
  end

  def update()
      sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
  end

  def self.delete_all()
      sql = "DELETE FROM films"
      values = []
      SqlRunner.run(sql, values)
  end


  def customers()
      sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
      values = [@id]
      customer_data = SqlRunner.run(sql, values)
      return customer_data.map { |customer| Customer.new(customer) }
  end
  ### Basic extensions:
    # - Buying tickets should decrease the funds of the customer by the price
    # - Check how many customers are going to watch a certain film

  def tickets
    sql = "SELECT tickets.* FROM tickets WHERE film_id = $1"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    return ticket_data.map{|ticket| Ticket.new(ticket)}
  end
#
#   def remaining_funds()
#     tickets = self.tickets()
#     ticket_prices = tickets.map{|ticket| ticket.free}
#     total_prices
#
# end

  #
  # def remaining_budget()
  #   castings = self.castings()
  #   casting_fees = castings.map{|casting| casting.fee}
  #   combined_fees = casting_fees.sum
  #   return @budget - combined_fees
  # end
end
