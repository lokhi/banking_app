require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it "should not be valid without any attribut" do
    expect(subject.valid?).to eql(false)
  end

end
