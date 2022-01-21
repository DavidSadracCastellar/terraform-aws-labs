data "aws_route53_zone" "selected" {
  name         = "test.com."
  private_zone = false
}
