require File.dirname(__FILE__) + '/unit_helper'

describe 'Product' do

  before do
    rate_limit = Celluloid::RateLimiter.new(100, 1)
    Celluloid::Actor[:session_pool] = ImpactGuns::Session.pool(args: [rate_limit])
  end

  describe 'built without any values' do
    before do
      @product = ImpactGuns::Product.new
    end

    it "should not be valid" do
      expect(@product).not_to be_valid
    end
  end

  describe 'built with just url' do
    before do
      @product = ImpactGuns::Product.new(url: 'foo')
    end

    it "should be valid" do
      expect(@product).to be_valid
    end
  end

  describe 'non-existent' do
    before do
      @product = ImpactGuns::Product.new(url: 'foo')
    end

    it "should raise an error" do
      VCR.use_cassette('product invalid') do
        expect{|p| p.load}.to raise_error
      end
    end
  end

  describe 'in-stock' do
    before do
      VCR.use_cassette('product Mossberg 590A1') do
        @product = ImpactGuns::Product.find('product.aspx?zpid=34852')
      end
    end

    it "should show in stock" do
      expect(@product.in_stock).to be_true
    end

    it "should have a price" do
      expect(@product.price).to eq(Money.parse("$689.99"))
    end

    it "should have a manufacturer code" do
      expect(@product.mfg_code).to eq('53690')
    end

    it "should have a item number" do
      expect(@product.item_no).to eq('015813536905')
    end

    it "should have a status" do
      expect(@product.status).to eq('In Stock Now!')
    end

    it "should have a description" do
      expect(@product.description).to match(/Heavy-walled barrel with Parkerized finish/)
    end

    it "should have a name" do
      expect(@product.name).to eq('Mossberg 590A1 Special Purpose 12 Gauge 18.5" 6 Position Stock')
    end

    
  end

  describe 'out of stock' do
    before do
      VCR.use_cassette('product FN PS90') do
        @product = ImpactGuns::Product.find('fn-ps90-triple-rail-10rd-green-3818950140-818513004824.aspx')
      end
    end

    it "should show as out of stock" do
      expect(@product.in_stock).to be_false
    end
  end

  describe 'without a price' do
    before do
      VCR.use_cassette('product HK MR556') do
        @product = ImpactGuns::Product.find('product.aspx?zpid=29246')
      end
    end

    it "should set price to nil" do
      expect(@product.price).to be_nil
    end
  end

end
