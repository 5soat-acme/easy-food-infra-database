# Easy Food Infra Database

## Arquivos Terraform
Na pasta **terraform** há os arquivos do Terraform para gerenciar a infraestrutura de banco de dados do projeto **[Easy Food](https://github.com/5soat-acme/easy-food)**.

Os arquivos Terraform contidos nesse repositório cria a seguinte infraestrutura na AWS:
- Cluster banco de dados RDS Aurora PostgreSQL
- Cria as tabelas e insere alguns registros iniciais para serem utilizados nos testes da API. Para esse ponto, é utilizado uma instância EC2 como Bastion via SSH.

**Obs.:** Necessário informar no arquivo **terraform/variables.tf** as informações referentes a VPC da conta da AWS Academy

## Workflow - Github Action
O repositório ainda conta com um workflow para criar a infraestrutura na AWS quando houver **push** na branch **main**.

Para o correto funcionamento do workflow é necessário configurar as seguintes secrets no repositório, de acordo com a conta da AWS Academy:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_SESSION_TOKEN


<br>
<br>
<br>
<br>

**Observação antes de fazer o merge para a main:** <br>
No arquivo: <br>
**.github\workflows\terraform-ci-cd.yml** <br>
Lembrar de voltar no **Terraform Apply** o if apenas para push na branch main:<br>
**if: github.ref == 'refs/heads/main' && github.event_name == 'push'**