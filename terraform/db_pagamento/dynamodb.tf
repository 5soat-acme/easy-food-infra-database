resource "aws_dynamodb_table" "pagamento" {
  name         = "Pagamentos"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"
  range_key    = "PedidoId"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "PedidoId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "transacoes" {
  name         = "Transacoes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"
  range_key    = "PagamentoId"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "PagamentoId"
    type = "S"
  }

  global_secondary_index {
    name            = "PagamentoId-index"
    hash_key        = "PagamentoId"
    projection_type = "ALL"
  }
}