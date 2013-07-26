require 'spec_helper'

describe Spree::Product do

  context "attributes translations" do
    subject(:product) {
      p = create(:product)
      p.set_translations en: { name: "Product #1", description: "An amazing product!", meta_keywords: "english key", meta_description: "english description" },
                         it: { name: "Prodotto #1", description: "Un prodotto meraviglioso!", meta_keywords: "key italiana", meta_description: "descrizione italiana" },
                         de: { name: "Produkt #1", description: "Ein fantastisches Produkt", meta_keywords: "deutsch key", meta_description: "deutsch beschreibung"}
      p.save!; p
    }

    context "english" do
      before(:all) { I18n.locale = :en }

      its(:name) { should eq "Product #1" }
      its(:description) { should eq "An amazing product!" }
      its(:meta_keywords) { should eq "english key" }
      its(:meta_description) { should eq "english description" }
      its(:permalink) { should eq "product-number-1" }
    end

    context "italiano" do
      before(:all) { I18n.locale = :it }

      its(:name) { should eq "Prodotto #1" }
      its(:description) { should eq "Un prodotto meraviglioso!" }
      its(:meta_keywords) { should eq "key italiana" }
      its(:meta_description) { should eq "descrizione italiana" }
      its(:permalink) { should eq "prodotto-number-1" }
    end

    context "deutsch" do
      before(:all) { I18n.locale = :de }

      its(:name) { should eq "Produkt #1" }
      its(:description) { should eq "Ein fantastisches Produkt" }
      its(:meta_keywords) { should eq "deutsch key" }
      its(:meta_description) { should eq "deutsch beschreibung" }
      its(:permalink) { should eq "produkt-number-1" }
    end

  end

  context "permalink translation" do
    let!(:product) { create :simple_product, name: "Foo" }
    before(:all) { I18n.locale = :it }

    it "adds a number when there's already a product with that name" do
      product2 = create :simple_product, name: "Foo"
      product3 = create :simple_product, name: "Foo"
      product.set_translations en: { name: "Foo" }, it: { name: "Antani" }, de: { name: "Otto" }
      product2.set_translations en: { name: "Foo" }, it: { name: "Antani" }, de: { name: "Otto" }
      product3.set_translations en: { name: "Foo" }, it: { name: "Antani" }, de: { name: "Otto" }
      [:en, :it, :de].each do |lang|
        I18n.with_locale(lang) { [product, product2, product3].map(&:save!) }
      end
      I18n.with_locale(:en) do
        expect(product2.permalink).to eq "foo-001"
        expect(product3.permalink).to eq "foo-002"
      end
      I18n.with_locale(:it) do
        expect(product2.permalink).to eq "antani-001"
        expect(product3.permalink).to eq "antani-002"
      end
      I18n.with_locale(:de) do
       expect(product2.permalink).to eq "otto-001"
       expect(product3.permalink).to eq "otto-002"
      end
    end
  end

  describe ".like_any" do
    before(:all) { I18n.locale = :en }

    it "searches for fields in current translation only" do
      {foo: :antani, bar: :sbiliguda}.each {|en, it| create(:simple_product, name: en).set_translations(en: {name: en}, it: {name: it})}
      [:en, :it].each do |lang|
        I18n.with_locale(lang) {Spree::Product.all.map &:save!}
      end
      I18n.with_locale(:en) do
        expect(Spree::Product.like_any([:name], %w[fo ba]).count).to eq 2
        expect(Spree::Product.like_any([:name], %w[fo anta]).count).to eq 1
        expect(Spree::Product.like_any([:name], %w[fo]).first.name).to eq "foo"
      end
      I18n.with_locale(:it) do
        expect(Spree::Product.like_any([:name], %w[anta sbili]).count).to eq 2
        expect(Spree::Product.like_any([:name], %w[anta bar]).count).to eq 1
        expect(Spree::Product.like_any([:name], %w[anta]).first.name).to eq "antani"
      end
    end
  end

end
