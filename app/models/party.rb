class Party < ApplicationRecord
  belongs_to :account
  belongs_to :contract
end
