Spree::Product.class_eval do
  translates :name, :description, :meta_description, :meta_keywords, :permalink,
             :fallbacks_for_empty_translations => true

  def to_param
    permalink.presence || name.to_s.to_url
  end

  def save_permalink
    permalink_value = name.to_s.to_url

    field = self.class.permalink_field
    # Do other links exist with this permalink? Just look at the name
    pt_table = Spree::Product::Translation.arel_table
    other = self.class.with_translations(I18n.locale).where(pt_table[:permalink].matches("#{permalink_value}%")).select { |p| p.permalink =~ /#{permalink_value}(-[0-9]+|$)/ }
    #other = self.class.where("permalink like ?", '#{permalink_value}%').select { |p| p.permalink =~ /#{permalink_value}(-[0-9]+|$)/ }
    if other.any?
      # Find the existing permalink with the highest number, and increment that number.
      # (If none of the existing permalinks have a number, this will evaluate to 1.)
      number = other.map { |o| o.permalink[/-(\d+)$/, 1].to_i }.max + 1
      permalink_value += "-%03.f" % number #fill with 0
    end
    write_attribute(field, permalink_value)
  end

  before_validation(:on => :update) { save_permalink }

  def self.like_any(fields, values)
    translations = Spree::Product::Translation.arel_table
    conditions = fields.map{|f| values.map{|v| translations[f].matches("%#{v}%")}}.flatten.inject{|memo, c| memo.or(c)}
    self.with_translations(I18n.locale).where(conditions)
  end
end
