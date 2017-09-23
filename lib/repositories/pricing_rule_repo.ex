defmodule PricingRuleRepo do
  @docmodule false

  @behaviour RepositoryBehaviour

  use Repository

  @relation "pricing_rules"
  @returning_type %PricingRules.Item{}

  def relation, do: @relation
  def returning_type, do: @returning_type
end