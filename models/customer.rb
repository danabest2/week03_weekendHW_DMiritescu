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
    sql = "SELECT films.* FROM flims INNER JOIN tickets ON films.id = tickets.customer_id where customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map { |film| Film.new(film) }
end

# end



# display all the stars for a particular movie
# def stars()
#     sql = "SELECT stars.* FROM stars INNER JOIN castings ON stars.id = castings.star_id WHERE movie_id = $1"
#     values = [@id]
#     star_data = SqlRunner.run(sql, values)
#     return Star.map_items(star_data)
#   end


end
