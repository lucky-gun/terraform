variable "oidc" {
  type = object({
    oidc_issuer_url = string
    tags            = map(string)
  })
}
