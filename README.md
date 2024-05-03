# Easy Food Infra Database

## Arquivos Terraform :cloud:
Na pasta **terraform** há os arquivos do Terraform para gerenciar a infraestrutura de banco de dados do projeto **[Easy Food](https://github.com/5soat-acme/easy-food)**.

Os arquivos Terraform contidos nesse repositório cria a seguinte infraestrutura na AWS:
- Cluster RDS Aurora PostgreSQL
- Cria as tabelas e insere alguns registros iniciais para serem utilizados nos testes da API. Para esse ponto, é utilizado uma instância EC2 como Bastion via SSH.

**Obs.:** Necessário informar no arquivo **terraform/variables.tf** as informações referentes a VPC da conta da AWS Academy

## Workflow - Github Action :arrow_forward:
O repositório ainda conta com um workflow para criar a infraestrutura na AWS quando houver **push** na branch **main**.

Para o correto funcionamento do workflow é necessário configurar as seguintes secrets no repositório, de acordo com a conta da AWS Academy:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN

Além dos secrets da AWS, é necessário configurar uma secret com a senha do banco de dados:
- DATABASE_PASSWORD

## Justificativa da escolha do banco de dados :bulb:
Escolhemos o banco de dados **PostgreSQL**, devido ao projeto ainda estar em monolito, e a haver casos em que faça sentido ter um banco relacional, como por exemplo, o CRUD de produtos. <br>
Futuramente com a divisão do projeto em microsserviços, faz sentido a criação de um banco de dados NoSQL para alguns contextos, como por exemplo, o contexto de carrinho.