require "rails_helper"

RSpec.describe C, type: :model do
  subject { build :c }

  it { expect(subject).to be_valid }
  it { expect(subject).to respond_to :b }
  it { expect(subject).to respond_to :d }

  describe :scope do
    describe :type_x do
      it { expect { create(:c, type_name: :x) }.to change { C.type_x.count }.by 1 }
    end
  end
end
