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

  describe "generate" do
    it "sould set the ccv with 3 numbers string" do
      subject = FactoryBot.create(:card)
      subject.generate
      expect(subject.ccv.size).to eql(3)
      expect(subject.ccv !~ /\D/).to eql(true)
    end

    it "sould set the card numbers with 16 numbers string" do
      subject = FactoryBot.create(:card)
      subject.generate
      expect(subject.numbers.size).to eql(16)
      expect(subject.ccv !~ /\D/).to eql(true)
    end

    it "sould set the expiration date in one months" do
      subject = FactoryBot.create(:card)
      subject.generate
      expect(subject.expiration_date).to eql(Date.today + 1.month)
    end
  end

  describe "load_money" do
    it "sould add the amount in current_balance" do
      subject = FactoryBot.create(:card)
      subject.generate
      expect(subject.ccv.size).to eql(3)
      expect(subject.ccv !~ /\D/).to eql(true)
    end
  end
end
