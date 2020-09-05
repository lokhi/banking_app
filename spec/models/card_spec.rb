require 'rails_helper'

RSpec.describe Card, type: :model do
  it "should not be valid without any attribut" do
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid without a currency" do
    subject = FactoryBot.create(:card)
    subject.currency = nil
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid with an other currency than EUR,USD,GBP" do
    subject = FactoryBot.create(:card)
    subject.currency="XYZ"
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid if currency is different than the walle currency " do
    subject = FactoryBot.create(:card)
    subject.currency="USD"
    expect(subject.valid?).to eql(false)
  end

  #todo test generate
end
