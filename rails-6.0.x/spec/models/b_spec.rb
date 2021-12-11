require "rails_helper"

RSpec.describe B, type: :model do
  subject { build :b }

  it { expect(subject).to be_valid }
  it { expect(subject).to respond_to :a }
  it { expect(subject).to respond_to :cs }
end
