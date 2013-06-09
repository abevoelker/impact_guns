# -*- encoding: utf-8 -*-

require 'entasis'
require 'mechanize'
require 'andand'
require 'money'

module ImpactGuns
  class Product
    include Entasis::Model

    attributes :url, :name, :mfg_code, :item_no, :status,
               :description, :price, :image, :in_stock

    validates :url, presence: true

    def price=(p)
      @price = Money.parse(p) if p
    end

    def load(force=false)
      return true if @loaded && !force
      @loaded = true
      page = Celluloid::Actor[:session_pool].get("#{SITE_ROOT}/#{url}")
      self.name = page.at('.ProductTitle span').andand.text
      self.mfg_code = page.at('#ctl00_ctl00_MainContent_uxProduct_lblManuf').andand.
                      text.andand.match(/MANUFACTURER NO: (\S*)/).andand[1]
      self.item_no  = page.at('#ctl00_ctl00_MainContent_uxProduct_ProductID').andand.text
      self.description = page.at('.Features span').andand.text
      self.status = page.at('.StockMsg span').andand.text
      self.price = page.at('span.Price').andand.text || page.at('span.SalePrice').andand.text
      self.image = page.at('#CatalogItemImage').andand.attr('src')
      self.in_stock = !!page.at('.AddToCartButton a')
      self
    end

    def reload
      load(true)
    end

    def self.find(url)
      new(url: url).reload
    end

    def self.init_from_url(url)
      new(url: url)
    end

    def self.all_from_index_page(page)
      links = page.search('.ItemStyle .DetailLink a').map{|a| a.attr('href')}
      links.map{|l| init_from_url(l)}
    end

  end
end
