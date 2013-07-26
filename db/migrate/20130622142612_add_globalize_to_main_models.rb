class AddGlobalizeToMainModels < ActiveRecord::Migration
  def up
    attributes = { name: :string, description: :text, permalink: :string,
                   meta_description: :string, meta_keywords: :string }
    Spree::Product.create_translation_table!(attributes, { migrate_data: true })

    attributes = { name: :string, description: :text, permalink: :string }
    Spree::Taxon.create_translation_table!(attributes, { migrate_data: true })

    attributes = { name: :string }
    Spree::Taxonomy.create_translation_table!(attributes, { migrate_data: true })

    attributes = { name: :string, presentation: :string }
    Spree::OptionType.create_translation_table!(attributes, { migrate_data: true })
    Spree::OptionValue.create_translation_table!(attributes, { migrate_data: true })
    Spree::Property.create_translation_table!(attributes, { migrate_data: true })

    attributes = { name: :string }
    Spree::Role.create_translation_table!(attributes, { migrate_data: true })
  end

  def down
    Spree::Product.drop_translation_table! migrate_data: true
    Spree::Taxon.drop_translation_table! migrate_data: true
    Spree::Taxonomy.drop_translation_table! migrate_data: true
    Spree::OptionType.drop_translation_table! migrate_data: true
    Spree::OptionValue.drop_translation_table! migrate_data: true
    Spree::Property.drop_translation_table! migrate_data: true
    Spree::Role.drop_translation_table! migrate_data: true
  end
end
