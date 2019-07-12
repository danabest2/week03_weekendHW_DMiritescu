require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')

require ( 'pry-byebug' )

# Ticket.delete_all()
# Customer.delete_all()
# Film.delete_all()



film1 = Film.new({'title' => 'Castaway', 'price' => '10'})
film1.save()

film2 = Film.new({'title' => 'Godfather', 'price' => '15'})
film2.save()

film3 = Film.new({'title' => 'Midnight in Paris', 'price' => '20'})
film3.save()

customer1 = Customer.new({ 'name' => 'Tom', 'funds' => '10'})
customer1.save()

customer2 = Customer.new({ 'name' => 'Robert', 'funds' => '40'})
customer2.save()

customer3 = Customer.new({ 'name' => 'Nicky', 'funds' => '60'})
customer3.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id})
ticket1.save()

ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id})
ticket2.save()

ticket3 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer2.id})
ticket3.save()

ticket4 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer3.id})
ticket4.save()

ticket5 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer3.id})
ticket5.save()

ticket6 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer3.id})
ticket6.save()

binding.pry
nil
