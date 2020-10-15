require 'spec_helper'

RSpec.describe Idna do
  it 'has a version number' do
    expect(Idna::VERSION).to match /\d+\.\d+\.\d+/
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
        expect { Idna.to_ascii('a' * 100) }.to raise_error(Idna::Error::IDN2_TOO_BIG_LABEL)
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

  describe '#valid?' do
    context 'With components allowed' do
      example 'ASCII' do
        expect(Idna.valid?('test.com', components: true)).to eql(true)
      end

      example 'UTF-8' do
        expect(Idna.valid?('あいうえお.com', components: true)).to eql(true)
      end

      example 'Invalid ASCII' do
        expect(Idna.valid?('test_underscore.com', components: true)).to eql(false)
      end

      example 'Too long' do
        expect(Idna.valid?('*.' + ('a.b' * 30), components: true)).to eql(false)
      end
    end

    context 'Only one component allowed' do
      example 'ASCII' do
        expect(Idna.valid?('test')).to eql(true)
      end

      example 'UTF-8' do
        expect(Idna.valid?('あいうえお')).to eql(true)
      end

      example 'Invalid ASCII' do
        expect(Idna.valid?('test_underscore')).to eql(false)
      end

      example 'Too long' do
        expect(Idna.valid?('a' * 100)).to eql(false)
      end

      example 'With multiple components given anyway' do
        expect(Idna.valid?('test.com')).to eql(false)
      end
    end
  end
end
