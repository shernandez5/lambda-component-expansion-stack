require 'json'

module LambdaFunctions
  class Handler
    def self.process(event:,context:)
      nameQuery = event.dig("queryStringParameters", "name")
      name = nameQuery || "World"

      {
        statusCode: 200,
        headers: {
          'Content-Type' => 'text/html; charset=UTF-8'
        },
        body: "<html>
                <body>
                  <h1>Hello, #{name}!</h1>
                  <img src=\"https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg\" alt=\"A cute orange cat lying on its back.\">
                </body>
              </html>
          ",
      }
    end
  end
end
