require 'spec_helper'

describe Spree::Property do

  context "attributes translations" do
    subject(:property) {
      p = create(:property)
      p.set_translations en: { name: "name-property",   presentation: "English Property" },
                         it: { name: "nome-proprieta'", presentation: "Proprieta' Italiana" }
      p
    }

    context "english" do
      before(:all) { I18n.locale = :en }
      its(:name) { should eq "name-property" }
      its(:presentation) { should eq "English Property" }
    end

    context "italiano" do
      before(:all) { I18n.locale = :it }

      its(:name) { should eq "nome-proprieta'" }
      its(:presentation) { should eq "Proprieta' Italiana" }
    end
  end

end
