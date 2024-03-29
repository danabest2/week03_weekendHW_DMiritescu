require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :name, :funds


def initialize( options )
  @id = options['id'].to_i if options ['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers(
        name,
        funds
        )
        VALUES
        (
          $1, $2
        )
        RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run( sql, values ).first
  @id = customer['id'].to_i
end

def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
end

def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map { |film| Film.new(film) }
end
### Basic extensions
# Check how many tickets were bought by a customer

def tickets
  sql = "SELECT tickets.* FROM tickets WHERE customer_id = $1"
  values = [@id]
  ticket_data = SqlRunner.run(sql, values)
  return ticket_data.map{|ticket| Ticket.new(ticket)}
end

###
# Buying tickets should decrease the funds of the customer by the price

def films_price()
    sql = "SELECT * FROM films where customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map{|film| Film.new(film)}
  end

  def remaining_funds()
    films = self.films()
    film_prices = films.map{|film| film.price}
    combined_prices = film_prices.sum
    return @funds - combined_prices
  end




end
