require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it "should not be valid without any attribut" do
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid without a currency" do
    subject.current_balance=1000.00
    subject.company_id=2
    subject.master = false
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid with an other currency than EUR,USD,GBP" do
    subject.currency="XYZ"
    subject.company_id=2
    subject.master = false
    expect(subject.valid?).to eql(false)
  end

  it "should not be valid if already exist a wallet with the same company id and the same currency" do
      master_wallet_EUR = FactoryBot.create(:master_wallet_EUR)
      subject.currency="EUR"
      subject.company_id=1
      subject.master = false
      expect(subject.valid?).to eql(false)
  end
end
