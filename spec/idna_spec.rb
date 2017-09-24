require 'spec_helper'

RSpec.describe Idna do
  it 'has a version number' do
    expect(Idna::VERSION).to eq '0.1.0'
  end

  describe '#to_ascii' do
    describe 'Success' do
      example 'String is nil.' do
        expect(Idna.to_ascii(nil)).to eq(nil)
      end

      example 'Convert to ACE according to IDNA.' do
        expect(Idna.to_ascii('あいうえお')).to eq('xn--l8jegik')
      end
    end

    describe 'Error' do
      example 'The final output string is not within the (inclusive) range 1 to 63 characters.' do
        expect { Idna.to_ascii('a' * 100) }.to raise_error(Idna::Error::IDNA_INVALID_LENGTH)
      end
    end

    describe 'Option' do
      example 'Skip useless string.' do
        expect(Idna.to_ascii('a' * 100, skip_useless: true)).to eq('a' * 100)
      end
    end
  end

  describe '#to_unicode' do
    describe 'Success' do
      example 'String is nil.' do
        expect(Idna.to_unicode(nil)).to eq(nil)
      end

      example 'Convert to ACE according to IDNA.' do
        expect(Idna.to_unicode('xn--l8jegik')).to eq('あいうえお')
      end
    end

    describe 'Option' do
      example 'Skip useless string.' do
        expect(Idna.to_unicode('あ' * 100, skip_useless: true)).to eq('あ' * 100)
      end
    end
  end
end
