# Desafio Backend Inovamind

Essa é uma breve documentação sobre os componentes presentes na solução e sobre como rodar o projeto.

Componentes:

* Rails Api
* Mongodb
* Docker e Docker compose
* Github Actions

Principais Gems:

* mongoid
* jbuilder
* jwt
* nokogiri
* rspec-rails
* factory_bot_rails
</br>

## Como usar

Primeiramente instale o [docker](https://docs.docker.com/engine/install/ubuntu/) e o [docker-compose](https://docs.docker.com/compose/install/) na sua máquina.  

Após isso execute dentro da pasta do projeto:

~~~cmd
  docker-compose up --build
~~~

Esse comando irá baixar as imagens e as dependências necessárias para rodar o projeto.

## Rails Api

### Web-crawler

Foi utilizada a gem nokogiri para fazer o web-crawler das frases. O script para isto está em uma camada de services, pois fica mais fácil de dar manutenção, testar e escalar conforme for preciso.

### Autenticação

Para a autenticação foi utilizada a feature do has_secure_password em conjunto com a gem bcrypt e a gem jwt para o encode e decode do token. Assim como o script do web-crawler, o script e encode-decode fica em uma camada de service.

### Rotas, Login e Autenticação

Na criação das rotas temos um namespace api e um scope para as versões da api. Para fazer uma consulta na api é preciso primeiramente ter um user e logar com esse user.

</br>

Primeiro crie um user na rota:

```ruby
  curl -X POST -H "Content-Type: application/json" \
  -d '{"user": {"email": "test@email.com","password":"123456",
  "password_confirmation":"123456"}}' \
  http://localhost:3000/api/user

```

Após isso faça o login na rota de autenticação enviando o email e a senha:

```ruby
  curl -X POST -H "Content-Type: application/json" \
  -d '{"user": {"email": "test@email.com","password":"123456"}}' \
  http://localhost:3000/api/authentication
```

e receba uma resposta com um token:

```
  {"token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNjBkZGM1MjY1NjNmNGUwMDAxZDQzOGQ5IiwiZXhwIjoxNjI1MTQ4NjgwfQ.gcuJpe0__VvC3PgmUTw3hrvFMxCk_oDOt0UDLxmgVcQ"}

```

Este token vai no cabeçalho como autenticação do tipo Bearer.

### Rotas para pesquisa

Temos 3 rotas para pesquisa:

1. /api/quotes/:search_tag
2. /api/quotes/authors
3. /api/quotes/terms

Para a primeira rota passamos a consulta dessa forma:

```ruby
curl -X GET -H "Authorization: Bearer <token>" http://localhost:3000/api/quotes/love
```

Essa rota chega ao controller na action search_tag onde, primeiramente, é feita uma busca no banco mongo, se já tiverem frases com essa tag essas frases são retornadas, caso contrário e feito uma pesquisa no site [Quotes to Scrapper](http://quotes.toscrape.com/.). Os objetos são serializados com a ajuda do jbuilder, onde é possível definir a estrutura desejada.

Para a segunda rota temos:

```ruby
curl -X GET -H "Authorization: Bearer <token>" http://localhost:3000/api/quotes/authors
```

Nessa rota são retornados os autores das tags armazedas no banco.

Para a terceira rota temos uma pesquisa por termos dentro dos textos, utilizando os indexes de texto e o text_search do mongoid:

```ruby
-X GET -H "Authorization: Bearer <token>" -d 'term=love' http://localhost:3000/api/quotes/terms
```

O retorno essa obra são as quotes que possuem o termo pesquisado. Nesse, caso não é pesquisado pela tag e sim pelo texto da quote.

### Testes

Foram realizados alguns testes de model e testes de request utilizando o rspec e o factory_bot para as factories. Para rodar os testes basta executar o comando abaixo:

~~~cmd
  docker-compose exec app rspec
~~~

E todos os testes da aplicação serão rodados.

## Docker e Docker compose

Foi utilizado o docker para definição da imagem da api rails e o docker-compose foi utilizado para integração do mongodb com a api. Isso facilita a implantação da aplicação, bem como os testes.

## Github Actions

Tomei a liberdade de implementar um pipeline com o github actions, caso fosse preciso uma integração contínua. Nas actions está apenas o estágio de testes, mas também seria possivel adicionar mais estágios afim de garantir um deploy. O pipeline e rodado toda vez que um push e feito, mas também é possivel configurar para uma branch específica ou para um evento específico.
