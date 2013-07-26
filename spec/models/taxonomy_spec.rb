require 'spec_helper'

describe Spree::Taxonomy do

  context "attributes translations" do
    subject(:taxonomy) {
      p = create(:taxonomy)
      p.set_translations en: { name: "Category" },
                         it: { name: "Categoria" }
      p
    }

    context "english" do
      before(:all) { I18n.locale = :en }

      its(:name) { should eq "Category" }
    end

    context "italiano" do
      before(:all) { I18n.locale = :it }
      its(:name) { should eq "Categoria" }
    end
  end

end
