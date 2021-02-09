require "rails_helper"

RSpec.describe D, type: :model do
  subject { build :d }

  it { expect(subject).to be_valid }
end
