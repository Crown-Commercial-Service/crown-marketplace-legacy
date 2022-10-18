require 'rails_helper'

# rubocop:disable RSpec/NestedGroups
RSpec.describe Framework, type: :model do
  describe '.frameworks' do
    context 'when no scope is provided' do
      it 'returns RM6238, RM6187 and RM6240' do
        expect(described_class.frameworks).to eq %w[RM6238 RM6187 RM6240]
      end
    end

    context 'when the supply_teachers scope is provided' do
      it 'returns RM6238' do
        expect(described_class.supply_teachers.frameworks).to eq %w[RM6238]
      end
    end

    context 'when the management_consultancy scope is provided' do
      it 'returns RM6187' do
        expect(described_class.management_consultancy.frameworks).to eq %w[RM6187]
      end
    end

    context 'when the legal_services scope is provided' do
      it 'returns and RM6240' do
        expect(described_class.legal_services.frameworks).to eq %w[RM6240]
      end
    end
  end

  describe '.live_frameworks' do
    context 'when RM6238 goes live tomorrow' do
      include_context 'and RM6238 is live in the future'

      it 'returns RM6187 and RM6240' do
        expect(described_class.live_frameworks).to eq %w[RM6187 RM6240]
      end

      context 'and the supply_teachers scope is provided' do
        it 'returns an empty array' do
          expect(described_class.supply_teachers.live_frameworks).to eq %w[]
        end
      end
    end

    context 'when RM6240 goes live tomorrow' do
      include_context 'and RM6240 is live in the future'

      it 'returns RM6238 and RM6187, ' do
        expect(described_class.live_frameworks).to eq %w[RM6238 RM6187]
      end

      context 'and the legal_services scope is provided' do
        it 'returns an empty array' do
          expect(described_class.legal_services.live_frameworks).to eq %w[]
        end
      end
    end

    context 'when RM6238 is live today' do
      include_context 'and RM6238 is live today'

      it 'returns RM6238, RM6187 and RM6240' do
        expect(described_class.live_frameworks).to eq %w[RM6187 RM6240 RM6238]
      end

      context 'and the supply_teachers scope is provided' do
        it 'returns RM6238' do
          expect(described_class.supply_teachers.live_frameworks).to eq %w[RM6238]
        end
      end
    end

    context 'when RM6240 is live today' do
      include_context 'and RM6240 is live today'

      it 'returns RM6238, RM6187 and RM6240' do
        expect(described_class.live_frameworks).to eq %w[RM6238 RM6187 RM6240]
      end

      context 'and the legal_services scope is provided' do
        it 'returns RM6240' do
          expect(described_class.legal_services.live_frameworks).to eq %w[RM6240]
        end
      end
    end

    context 'when RM6238 went live yesterday' do
      it 'returns RM6238, RM6187 and RM6240' do
        expect(described_class.live_frameworks).to eq %w[RM6238 RM6187 RM6240]
      end

      context 'and the supply_teachers scope is provided' do
        it 'returns RM6238' do
          expect(described_class.supply_teachers.live_frameworks).to eq %w[RM6238]
        end
      end
    end

    context 'when RM6240 went live yesterday' do
      it 'returns RM6240, RM6187 and RM6240' do
        expect(described_class.live_frameworks).to eq %w[RM6238 RM6187 RM6240]
      end

      context 'and the legal_services scope is provided' do
        it 'returns  RM6240' do
          expect(described_class.legal_services.live_frameworks).to eq %w[RM6240]
        end
      end
    end
  end

  describe '.current_framework' do
    context 'when the supply_teachers scope is provided' do
      context 'when RM6238 goes live tomorrow' do
        include_context 'and RM6238 is live in the future'

        it 'returns nil' do
          expect(described_class.supply_teachers.current_framework).to be nil
        end
      end

      context 'when RM6238 is live today' do
        include_context 'and RM6238 is live today'

        it 'returns RM6238' do
          expect(described_class.supply_teachers.current_framework).to eq 'RM6238'
        end
      end

      context 'when RM6238 went live yesterday' do
        it 'returns RM6238' do
          expect(described_class.supply_teachers.current_framework).to eq 'RM6238'
        end
      end
    end

    context 'when the management_consultancy scope is provided' do
      it 'returns RM6187' do
        expect(described_class.management_consultancy.current_framework).to eq 'RM6187'
      end
    end

    context 'when the legal_services scope is provided' do
      context 'when RM6240 goes live tomorrow' do
        include_context 'and RM6240 is live in the future'

        it 'returns nil' do
          expect(described_class.legal_services.current_framework).to be nil
        end
      end

      context 'when RM6240 is live today' do
        include_context 'and RM6240 is live today'

        it 'returns RM6240' do
          expect(described_class.legal_services.current_framework).to eq 'RM6240'
        end
      end

      context 'when RM6240 went live yesterday' do
        it 'returns RM6240' do
          expect(described_class.legal_services.current_framework).to eq 'RM6240'
        end
      end
    end
  end

  describe '.live_framework?' do
    context 'when the supply_teachers scope is provided' do
      let(:result) { described_class.supply_teachers.live_framework?(framework) }

      context 'when the framework passed is RM6238' do
        let(:framework) { 'RM6238' }

        context 'and RM6238 goes live tomorrow' do
          include_context 'and RM6238 is live in the future'

          it 'returns false' do
            expect(result).to be false
          end
        end

        context 'when RM6238 is live today' do
          include_context 'and RM6238 is live today'

          it 'returns true' do
            expect(result).to be true
          end
        end

        context 'and RM6238 went live yesterday' do
          it 'returns true' do
            expect(result).to be true
          end
        end
      end

      context 'when the framework is not RM6238' do
        let(:framework) { 'RM6187' }

        it 'returns false' do
          expect(result).to be false
        end
      end
    end

    context 'when the management_consultancy scope is provided' do
      context 'when the framework is RM6187' do
        it 'returns true' do
          expect(described_class.management_consultancy.live_framework?('RM6187')).to be true
        end
      end

      context 'when the framework is not RM6187' do
        it 'returns false' do
          expect(described_class.management_consultancy.live_framework?('RM3788')).to be false
        end
      end
    end

    context 'when the legal_services scope is provided' do
      let(:result) { described_class.legal_services.live_framework?(framework) }

      context 'when the framework passed is RM6240' do
        let(:framework) { 'RM6240' }

        context 'and RM6240 goes live tomorrow' do
          include_context 'and RM6240 is live in the future'

          it 'returns false' do
            expect(result).to be false
          end
        end

        context 'when RM6240 is live today' do
          include_context 'and RM6240 is live today'

          it 'returns true' do
            expect(result).to be true
          end
        end

        context 'and RM6240 went live yesterday' do
          it 'returns true' do
            expect(result).to be true
          end
        end
      end

      context 'when the framework is not RM6240' do
        let(:framework) { 'RM6187' }

        it 'returns false' do
          expect(result).to be false
        end
      end
    end
  end

  describe '.status' do
    let(:result) { described_class.find_by(framework: framework).status }

    context 'when considering supply_teacher frameworks' do
      context 'and RM6238 goes live tomorrow' do
        include_context 'and RM6238 is live in the future'

        context 'and the frameworks is RM6238' do
          let(:framework) { 'RM6238' }

          it 'returns coming' do
            expect(result).to eq :coming
          end
        end
      end

      context 'when RM6238 is live today' do
        include_context 'and RM6238 is live today'

        context 'and the frameworks is RM6238' do
          let(:framework) { 'RM6238' }

          it 'returns live' do
            expect(result).to eq :live
          end
        end
      end

      context 'and RM6238 went live yesterday' do
        context 'and the frameworks is RM6238' do
          let(:framework) { 'RM6238' }

          it 'returns live' do
            expect(result).to eq :live
          end
        end
      end
    end

    context 'when considering management_consultancy frameworks' do
      let(:framework) { 'RM6187' }

      it 'returns live' do
        expect(result).to eq :live
      end
    end

    context 'when considering legal_services frameworks' do
      context 'and RM6240 goes live tomorrow' do
        include_context 'and RM6240 is live in the future'

        context 'and the frameworks is RM6240' do
          let(:framework) { 'RM6240' }

          it 'returns coming' do
            expect(result).to eq :coming
          end
        end
      end

      context 'when RM6240 is live today' do
        include_context 'and RM6240 is live today'

        context 'and the frameworks is RM6240' do
          let(:framework) { 'RM6240' }

          it 'returns live' do
            expect(result).to eq :live
          end
        end
      end

      context 'and RM6240 went live yesterday' do
        context 'and the frameworks is RM6240' do
          let(:framework) { 'RM6240' }

          it 'returns live' do
            expect(result).to eq :live
          end
        end
      end
    end
  end

  describe 'validating the live at date' do
    let(:framework) { create(:legacy_framework) }
    let(:live_at) { Time.zone.now + 1.day }
    let(:live_at_yyyy) { live_at.year.to_s }
    let(:live_at_mm) { live_at.month.to_s }
    let(:live_at_dd) { live_at.day.to_s }

    before do
      framework.live_at_yyyy = live_at_yyyy
      framework.live_at_mm = live_at_mm
      framework.live_at_dd = live_at_dd
    end

    context 'when considering live_at_yyyy and it is nil' do
      let(:live_at_yyyy) { nil }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:live_at].first).to eq 'Enter a valid \'live at\' date'
      end
    end

    context 'when considering live_at_mm and it is blank' do
      let(:live_at_mm) { '' }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:live_at].first).to eq 'Enter a valid \'live at\' date'
      end
    end

    context 'when considering live_at_dd and it is empty' do
      let(:live_at_dd) { '    ' }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:live_at].first).to eq 'Enter a valid \'live at\' date'
      end
    end

    context 'when considering the full live_at' do
      context 'and it is not a real date' do
        let(:live_at_yyyy) { live_at.year.to_s }
        let(:live_at_mm) { '2' }
        let(:live_at_dd) { '30' }

        it 'is not valid and has the correct error message' do
          expect(framework.valid?(:update)).to eq false
          expect(framework.errors[:live_at].first).to eq 'Enter a valid \'live at\' date'
        end
      end

      context 'and it is a real date' do
        it 'is valid' do
          expect(framework.valid?(:update)).to eq true
        end
      end
    end
  end

  describe 'validating the expires at date' do
    let(:framework) { create(:legacy_framework) }
    let(:expires_at) { Time.zone.now + 2.years }
    let(:expires_at_yyyy) { expires_at.year.to_s }
    let(:expires_at_mm) { expires_at.month.to_s }
    let(:expires_at_dd) { expires_at.day.to_s }

    before do
      framework.expires_at_yyyy = expires_at_yyyy
      framework.expires_at_mm = expires_at_mm
      framework.expires_at_dd = expires_at_dd
    end

    context 'when considering expires_at_yyyy and it is nil' do
      let(:expires_at_yyyy) { nil }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:expires_at].first).to eq 'Enter a valid \'expires at\' date'
      end
    end

    context 'when considering expires_at_mm and it is blank' do
      let(:expires_at_mm) { '' }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:expires_at].first).to eq 'Enter a valid \'expires at\' date'
      end
    end

    context 'when considering expires_at_dd and it is empty' do
      let(:expires_at_dd) { '    ' }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:expires_at].first).to eq 'Enter a valid \'expires at\' date'
      end
    end

    context 'when considering the full expires_at' do
      context 'and it is not a real date' do
        let(:expires_at_yyyy) { expires_at.year.to_s }
        let(:expires_at_mm) { '2' }
        let(:expires_at_dd) { '30' }

        it 'is not valid and has the correct error message' do
          expect(framework.valid?(:update)).to eq false
          expect(framework.errors[:expires_at].first).to eq 'Enter a valid \'expires at\' date'
        end
      end

      context 'and it is a real date' do
        it 'is valid' do
          expect(framework.valid?(:update)).to eq true
        end
      end
    end
  end

  describe 'validating the expires at date is after the live at date' do
    let(:framework) { create(:legacy_framework, live_at: today, expires_at: expires_at) }
    let(:today) { Time.zone.today }

    context 'when the expires at date is in the future' do
      let(:expires_at) { today + 1.year }

      it 'is valid' do
        expect(framework.valid?(:update)).to eq true
      end
    end

    context 'when the expires at date is the same as the live at date' do
      let(:expires_at) { today }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:expires_at].first).to eq "The 'expires at' date must be after the 'live at' date"
      end
    end

    context 'when the expires at date is before the live at date' do
      let(:expires_at) { today - 2.days }

      it 'is not valid and has the correct error message' do
        expect(framework.valid?(:update)).to eq false
        expect(framework.errors[:expires_at].first).to eq "The 'expires at' date must be after the 'live at' date"
      end
    end
  end
end
# rubocop:enable RSpec/NestedGroups
