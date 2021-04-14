# GitRepoApi

# 💻 Sobre o desafio

Nesse desafio, você deverá criar uma aplicação que consome a API do GitHub retornando a lista de repositórios de um usuário informado.
A rota para obter esse dado da API é `[https://api.github.com/users/danilo-vieira/repos](https://api.github.com/users/danilo-vieira/repos)` onde **danilo-vieira** deverá ser o nome do usuário que está solicitando a lista de repositórios, ou seja, esse dado deve ser dinâmico.

Não remova o Ecto na geração do seu projeto. Mais tarde, utilizaremos esse mesmo código juntamente com o Ecto para a resolução de outro desafio.

---

Para consumir a API do GitHub, crie um módulo para o seu client, utilizando a lib Tesla, como foi visto no módulo (link para a lib: [https://github.com/teamon/tesla](https://github.com/teamon/tesla)).

## O que deve ser retornado?

Para cada repositório de um usuário, você deve retornar apenas os seguintes campos vindos da API: `id`, `name`, `description`, `html_url` e `stargazers_count`.

## Rotas

A aplicação deverá possuir apenas uma rota que recebe o `username` do usuário e retorna os dados obtidos com status `200`.