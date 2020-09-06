module TargetTransfer
  extend ActiveSupport::Concern

  included do
    has_many :transfers, :as => :target_transfer
  end
end
