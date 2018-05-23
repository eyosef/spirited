require 'json'
require 'open-uri'

class Store1 

    def products
        products = open(ENV['lcbo_store1_key'])
        products_data = JSON.parse(products.read)

        products_data["result"].each do |product|
            store = Store.find_by(name: "Hwy 401 & Weston")

            new_product = Product.new(name: product["name"], variety: product["varietal"], style: product["style"])
            new_product.alcohol_content = product["alcohol_content"]
            new_product.price_in_cents = product["price_in_cents"]
            new_product.producer_name = product["producer_name"]
            new_product.serving_suggestion = product["serving_suggestion"]
            new_product.flavor_profile = product["tasting_note"]
            new_product.image = product["image_thumb_url"]

            if store.products.empty? 
                    new_product.store_id = store.id
                    new_product.save

                    store.products << new_product
                    store.save
            else 
                unless store.products.one? {|inventory| inventory.name == new_product.name }
                        new_product.store_id = store.id
                        new_product.save
    
                        store.products << new_product
                        store.save
                end #unless 
            end #if conditional
        end #each iteration
    end  #products method
end
