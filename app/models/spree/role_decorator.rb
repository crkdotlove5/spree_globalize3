Spree::Role.class_eval do
  translates :name,
             :fallbacks_for_empty_translations => true
end
