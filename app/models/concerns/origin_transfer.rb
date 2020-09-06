module OriginTransfer
  extend ActiveSupport::Concern

  included do
    has_many :transfers, :as => :origin_transfer
  end
end
