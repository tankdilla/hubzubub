class Business < Entity
  has_many :addresses
  embeds_many :identifiable_entries
end