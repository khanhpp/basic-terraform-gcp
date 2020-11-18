# We use one and only one gcs bucket to store all terraform states
# So this gcs backend config should be the same across all terraform modules

# Except for `prefix` attribute, which must be unique for each module

terraform {
  backend "gcs" {
    bucket = "khanhpham2"
    prefix = "gcp/terraform-state"
  }
}

