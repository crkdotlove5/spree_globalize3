Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  localized do
    resources :products
  end
end
