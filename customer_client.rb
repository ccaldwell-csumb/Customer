require 'httparty'

class CustomerQuery
  
  include HTTParty

    # default_options.update(verify: false) # Turn off SSL
    base_uri  "http://localhost:8080" 
    headers = { 'Content-Type' => 'application/json',
                'ACCEPT' => 'application/json'}

  def self.registerRequest(args)

    body = { email: args[2], firstName: args[1], lastName: args[0] }
    response = post(
      '/customers',
      :body => body.to_json,
      :headers => headers
    )

    puts "status code " + response.code.to_s
    puts response.body
  end

  def self.emailRequest(args)
    query = { "email" => args[0] }
    response = get(
        '/customers/email',
        :query => query,
        :headers => headers
    )
    puts "status code " + response.code.to_s
    puts response.body
  end

  def self.idRequest(args)
    response = get(
        "/customers/#{args[0]}",
        :headers => headers
    )
    puts "status code " + response.code.to_s
    puts response.body
  end
end



command = ''

while command != 'quit'

  puts 'What do you want to do: register, email, id or quit'
  command = gets.chomp!

  case command.downcase
  when 'register'
    puts 'enter lastName, firstName and email for new customer'
    args = gets.chomp!.split(' ')
    CustomerQuery.registerRequest(args)
  when 'email'
    puts 'enter email'
    args = gets.chomp!.split(' ')
    CustomerQuery.emailRequest(args)
  when 'id'
    puts 'enter id'
    args = gets.chomp!
    CustomerQuery.idRequest(args)
  when 'quit'
    return
  end
  puts ''
end


