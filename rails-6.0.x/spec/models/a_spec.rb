require "rails_helper"

RSpec.describe A, type: :model do
  subject { build :a }

  it { expect(subject).to be_valid }
  it { expect(subject).to respond_to :bs }
  it { expect(subject).to respond_to :cs }
  it { expect(subject).to respond_to :ds }

  describe :c_type_xs do
    it do
      expect {
        b = create(:b, a: subject)
        c = create(:c, b: b)
      }.to change { subject.c_type_xs.count }.by 1
    end
  end

  describe :ds do
    it do
      expect {
        d = create(:d)
        b = create(:b, a: subject)
        c = create(:c, b: b, type_name: :x, d: d)
      }.to change { subject.ds.count }.by 1
    end
  end

  describe :includes do
    describe :type_x do
      before do
        d = create(:d)
        b = create(:b, a: subject)

        c = create(:c, b: b, type_name: :x, d: d)
        c = create(:c, b: b, type_name: :not_x)
        c = create(:c, b: b, type_name: :not_x, d: d)
        c = create(:c, b: b, type_name: :not_x, d: create(:d))
      end

      it { expect(A.find(subject.id).bs.size).to eq 1 }
      it { expect(A.find(subject.id).cs.size).to eq 4 }
      it { expect(A.includes(:c_type_xs).find(subject.id).c_type_xs.size).to eq 1 }
      it { expect(A.includes(:ds).find(subject.id).ds.size).to eq 2 }

      it { expect(A.includes(:c_type_xs, :ds).find(subject.id).c_type_xs.size).to eq 1 }
      it("if you switch includes around, you get different results") do
        expect(A.includes(:ds, :c_type_xs).find(subject.id).c_type_xs.size).to eq 1
      end

      it { expect(A.includes(:ds).find(subject.id).ds.size).to eq 2 }
      it { expect(A.includes(:ds, :c_type_xs).find(subject.id).ds.size).to eq 2 }
      it { expect(A.includes(:c_type_xs, :ds).find(subject.id).ds.size).to eq 2 }
    end
  end

  describe :eager_load do
    before do
      d = create(:d)
      by = create(:b, a: subject, name: :y)
      bz = create(:b, a: subject, name: :z)

      c = create(:c, b: by, type_name: :x, d: d)
      c = create(:c, b: bz, type_name: :not_x)
      c = create(:c, b: bz, type_name: :not_x, d: d)
      c = create(:c, b: bz, type_name: :not_x, d: create(:d))
    end

    it { expect(A.find(subject.id).bs.size).to eq 2 }
    it { expect(A.find(subject.id).cs.size).to eq 4 }
    it { expect(A.eager_load(:ds).find(subject.id).ds.size).to eq 2 }

    describe :type_x do
      it { expect(A.eager_load(:c_type_xs).find(subject.id).c_type_xs.size).to eq 1 }

      it { expect(A.eager_load(:c_type_xs, :ds).find(subject.id).c_type_xs.size).to eq 1 }
      it("doesn't have the problem with ordering") do
        expect(A.eager_load(:ds, :c_type_xs).find(subject.id).c_type_xs.size).to eq 1
      end

      it { expect(A.eager_load(:ds, :c_type_xs).find(subject.id).ds.size).to eq 2 }
      it { expect(A.eager_load(:c_type_xs, :ds).find(subject.id).ds.size).to eq 2 }
    end

    describe 'when c filtered by b' do
      it { expect(A.eager_load(:c_of_by).find(subject.id).c_of_by.size).to eq 1 }

      it { expect(A.eager_load(:c_of_by, :ds).find(subject.id).c_of_by.size).to eq 1 }
      it("if you switch eager_load around, you get different results") do
        expect(A.eager_load(:ds, :c_of_by).find(subject.id).c_of_by.size).to eq 1
      end

      it { expect(A.eager_load(:c_of_by, :ds).find(subject.id).ds.size).to eq 2 }
      it { expect(A.eager_load(:ds, :c_of_by).find(subject.id).ds.size).to eq 2 }
    end
  end
end
