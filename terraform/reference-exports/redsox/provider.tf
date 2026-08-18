provider "azurerm" {
  features {
  }
  use_oidc                        = false
  resource_provider_registrations = "none"
  subscription_id                 = "ad5c68b6-779c-4514-a4bf-f134fbcf1e0e"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
}
