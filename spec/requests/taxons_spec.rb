require 'spec_helper'

describe "taxon page" do
  let!(:taxon) {
    t = create :taxon
    t.set_translations en: { name: "Ruby on Rails" },
                       it: { name: "Rubino sui Binari" }
    t.save!; t
  }
  url_en = "/t/ruby-on-rails?locale=en"
  url_it = "/t/rubino-sui-binari?locale=it"


  context "english" do
    before(:all) { I18n.locale = :en }

    it "shows #{url_en} page in english" do
      visit url_en
      expect(page.first('title').text).to have_content "Ruby on Rails"
      expect(page.first('title').text).not_to have_content "Rubino sui Binari"
    end

    it "doesn't show #{url_it} page" do
      visit url_it
      expect(page.status_code).to eq 404
    end
  end

  context "italian" do
    before(:all) { I18n.locale = :it }

    it "shows #{url_it} page in italian" do
      visit url_it
      expect(page.first('title').text).to have_content "Rubino sui Binari"
      expect(page.first('title').text).not_to have_content "Ruby on Rails"
    end

    it "doesn't show #{url_en} page" do
      visit url_en
      expect(page.status_code).to eq 404
    end
  end
end
