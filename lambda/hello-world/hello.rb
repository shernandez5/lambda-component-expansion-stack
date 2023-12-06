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
                  <main>
                    <section>
                      <h2>Cat Photos</h2>
                      <!-- TODO: Add link to cat photos -->
                      <p>Click here to view more <a target="_blank" href="https://freecatphotoapp.com">cat photos</a>.</p>
                      <a href="https://freecatphotoapp.com"><img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/relaxing-cat.jpg" alt="A cute orange cat lying on its back."></a>
                    </section>
                    <section>
                      <h2>Cat Lists</h2>
                      <h3>Things cats love:</h3>
                      <ul>
                        <li>cat nip</li>
                        <li>laser pointers</li>
                        <li>lasagna</li>
                      </ul>
                    </section>
                  </main>
                </body>
              </html>
          ",
      }
    end
  end
end
