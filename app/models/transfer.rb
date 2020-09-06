class Transfer < ApplicationRecord
  belongs_to :origin_transfer, :polymorphic => true
  belongs_to :target_transfer, :polymorphic => true
end
