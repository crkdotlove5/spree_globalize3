require 'spec_helper'

describe Spree::Taxon do

  context "attributes translations" do
    subject(:taxon) {
      t = create(:taxon)
      t.set_translations en: { name: "Ruby on Rails", description: "A category" },
                         it: { name: "Rubino sui Binari", description: "Una categoria" }
      t
    }

    context "english" do
      before(:all) { I18n.locale = :en }

      its(:name) { should eq "Ruby on Rails" }
      its(:description) { should eq "A category" }
    end

    context "italiano" do
      before(:all) { I18n.locale = :it }

      its(:name) { should eq "Rubino sui Binari" }
      its(:description) { should eq "Una categoria" }
    end
  end


  context "permalink translations" do
    let!(:taxon) { create :taxon }

    before(:all) { I18n.locale = :en }

    it "updates permalink on name change for current locale only" do
      I18n.with_locale(:it) do
        taxon.update_attributes(name: "Rubino sui Binari")
        expect(taxon.permalink).to eq("rubino-sui-binari")
      end
      expect(taxon.permalink).to eq("ruby-on-rails")
    end

    it "updates children permalink on name change for current locale only" do
      subtaxon = create(:taxon, name: "Developer")
      subtaxon.set_translations it: { name: "Developer" }
      taxon.children << subtaxon

      I18n.with_locale(:it) do
        taxon.update_attributes(name: "Rubino sui Binari")
        expect(subtaxon.permalink).to eq("rubino-sui-binari/developer")
      end
      expect(subtaxon.permalink).to eq("ruby-on-rails/developer")
    end
  end

end
