resource "aws_dynamodb_table" "review_table" {
  name         = "google_play_reviews"
  hash_key     = "review_id"
  range_key    = "app_id"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "review_id"
    type = "S"
  }

  attribute {
    name = "app_id"
    type = "S"
  }
}
