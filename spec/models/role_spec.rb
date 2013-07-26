require 'spec_helper'

describe Spree::OptionType do

  context "attributes translations" do
    subject(:option_type) {
      p = create(:option_type)
      p.set_translations en: { name: "pilot"},
                         it: { name: "pilota"}
      p
    }

    context "english" do
      before(:all) { I18n.locale = :en }
      its(:name) { should eq "pilot" }
    end

    context "italiano" do
      before(:all) { I18n.locale = :it }

      its(:name) { should eq "pilota" }
    end
  end

end
