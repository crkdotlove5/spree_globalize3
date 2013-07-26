Spree::Taxon.class_eval do
  translates :name, :description, :permalink,
             :fallbacks_for_empty_translations => true

  before_update :set_permalink

  # Always update the permalink and his children
  def set_permalink
    if parent.present?
      self.permalink = [parent.permalink, name.to_url].join('/')
    else
      self.permalink = name.to_url
    end
    children.each { |c| c.set_permalink; c.save! }
    self.permalink
  end
end
