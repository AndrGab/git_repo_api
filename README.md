# GitRepoApi

# 💻  Desafio: Consumindo APIs

Nesse desafio, você deverá criar uma aplicação que consome a API do GitHub retornando a lista de repositórios de um usuário informado.
A rota para obter esse dado da API é `[https://api.github.com/users/danilo-vieira/repos](https://api.github.com/users/danilo-vieira/repos)` onde **danilo-vieira** deverá ser o nome do usuário que está solicitando a lista de repositórios, ou seja, esse dado deve ser dinâmico.

Não remova o Ecto na geração do seu projeto. Mais tarde, utilizaremos esse mesmo código juntamente com o Ecto para a resolução de outro desafio.

---

Para consumir a API do GitHub, crie um módulo para o seu client, utilizando a lib Tesla, como foi visto no módulo (link para a lib: [https://github.com/teamon/tesla](https://github.com/teamon/tesla)).

## O que deve ser retornado?

Para cada repositório de um usuário, você deve retornar apenas os seguintes campos vindos da API: `id`, `name`, `description`, `html_url` e `stargazers_count`.

## Rotas

A aplicação deverá possuir apenas uma rota que recebe o `username` do usuário e retorna os dados obtidos com status `200`.



# 💻 Desafio: Testando requisições com bypass 

Nesse desafio, você deverá testar o cliente criado no desafio anterior usando a lib bypass (link: [https://github.com/PSPDFKit-labs/bypass](https://github.com/PSPDFKit-labs/bypass)) aplicando tudo que aprendeu até agora!

Sinta-se livre para melhorar ainda mais a sua aplicação adicionando features se desejar e adicionando testes para essas novas features.

# 💻 Desafio: Autenticação JWT

Nesse desafio, você irá implementar uma nova feature para a aplicação desenvolvida no desafio Consumindo APIs
A aplicação deve possuir uma entidade `User` onde cada usuário possuirá apenas um id e senha. Ao fazer uma requisição para a rota de criação de usuários, deve ser enviado apenas a senha a ser cadastrada para o novo usuário, já o id deverá ser gerado pelo servidor e retornado no corpo da resposta.

Lembre-se de salvar o hash da senha no banco, não a senha "pura".

Para realizar a autenticação, deve ser enviado no corpo da requisição o id e senha e o retorno dessa chamada, em caso de sucesso, deverá possuir o token JWT gerado, exemplo:

```elixir
# Rota post /users/login

# Corpo da requisição
{id: "d4f0e64b-cc3f-4c09-b64d-ef450883e4e5", senha: "123456"}

# Resposta da chamada
{token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJCYW5hbmEiLCJuYW1lIjoiQmFuYW5hIiwiaWF0IjoxNTE2MjM5MDIyfQ.82aOexgMqejDxJzZzoBmVB_fPLiKRXe1rFEfoPl1sDs"}
```

Você pode usar a biblioteca Guardian para trabalhar com autenticação JWT: [https://github.com/ueberauth/guardian](https://github.com/ueberauth/guardian)

Ao chamar a rota que lista os repositórios de um usuário, será necessário enviar também o token JWT de um usuário que se autenticou na aplicação. Ou seja, apenas usuários cadastrados na aplicação podem fazer a listagem de repositórios.

---

Para enviar o desafio, você pode implementar a feature no mesmo repositório do desafio **Consumindo APIs** e enviar o link com o código atualizado sem a necessidade de criar um novo repositório.

# 💻 Desafio: Token Refrese

Continuando com o código implementado no desafio Autenticação JWT, você deverá customizar o tempo de validade de um token para um minuto e renovar ele a cada requisição feita desde que ainda esteja válido.

1 - Para alterar a duração do token, veja a opção `:ttl` na documentação oficial da função `encode_and_sign/4`: [https://hexdocs.pm/guardian/Guardian.html#encode_and_sign/4](https://hexdocs.pm/guardian/Guardian.html#encode_and_sign/4)

2 - Para renovar um token, confira a documentação da função `refresh/3`:
   [https://hexdocs.pm/guardian/Guardian.Token.Jwt.html#refresh/3](https://hexdocs.pm/guardian/Guardian.Token.Jwt.html#refresh/3)

Exemplo:

```elixir
# Refresh a token before it expires
{:ok, _old_stuff, {new_token, new_claims}} = MyApp.Guardian.refresh(token)
```