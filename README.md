# Easy Food Infra Database

## Arquivos Terraform :cloud:
Na pasta **terraform** há os arquivos do Terraform para gerenciar a infraestrutura de banco de dados dos microsserviços do projeto **[Easy Food](https://github.com/5soat-acme/easy-food)**. Microsserviços:
- [Easy Food Pedido](https://github.com/5soat-acme/easy-food-pedido)
- [Easy Food Pagamento](https://github.com/5soat-acme/easy-food-pagamento)
- [Easy Food Preparo e Entrega](https://github.com/5soat-acme/easy-food-preparoentrega)

<br>

Os arquivos Terraform contidos nesse repositório cria a seguinte infraestrutura na AWS:
- Easy Food Pedido
    - Cluster RDS Aurora PostgreSQL
    - Cria as tabelas e insere alguns registros iniciais para serem utilizados nos testes da API. Para esse ponto, é utilizado uma instância EC2 como Bastion via SSH.
- Easy Food Pagamento
    - Cria as tabelas **Pagamentos** e **Transasoes** no banco de dados NoSQL DynamoDB.
- Easy Food Preparo e Entrega
    - Cluster RDS Aurora PostgreSQL
    - Cria as tabelas. Para esse ponto, é utilizado uma instância EC2 como Bastion via SSH.

**Obs.:** Necessário informar no arquivo **terraform/variables.tf** as informações referentes a VPC da conta da AWS Academy

## Workflow - Github Action :arrow_forward:
O repositório ainda conta com um workflow para criar a infraestrutura na AWS quando houver **push** na branch **main**.

Para o correto funcionamento do workflow é necessário configurar as seguintes secrets no repositório, de acordo com a conta da AWS Academy:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN

Além dos secrets da AWS, é necessário configurar uma secret com a senha do banco de dados PostgreSQL:
- DATABASE_PASSWORD

## Diagrama Entidade Relacionamento(DER) :bookmark_tabs:
Na pasta **docs/der** possui os Diagramas Entidade Relacionamento de cada contexto.