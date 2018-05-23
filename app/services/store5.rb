require 'json'
require 'open-uri'

class Store5 
    def products
        products = open(ENV['lcbo_store5_key'])
        products_data = JSON.parse(products.read)

        products_data["result"].each do |product|

            new_product = Product.new(name: product["name"], variety: product["varietal"], style: product["style"])
            new_product.alcohol_content = product["alcohol_content"]
            new_product.price_in_cents = product["price_in_cents"]
            new_product.producer_name = product["producer_name"]
            new_product.serving_suggestion = product["serving_suggestion"]
            new_product.flavor_profile = product["tasting_note"]
            new_product.image = product["image_thumb_url"]

            store = Store.find_by(name: "Queen & Coxwell")

            if store == nil 
                store = Store.new(name: "Queen & Coxwell")
                store.address_line_1 = "1654 Queen Street East"
                store.address_line_2 = nil 
                store.city = "Toronto"
                store.zipcode = "M4L1G3"
                store.phone_number = "(416) 691-9758"
                store.bilingual = true 
                store.tasting_bar = false 
                store.public_transport = true
                
                store.hours_of_operation << []
                store.hours_of_operation[0] << 660
                store.hours_of_operation[0] << 1080

                store.hours_of_operation << []
                store.hours_of_operation[1] << 0000
                store.hours_of_operation[1] << 0000

                store.hours_of_operation << []
                store.hours_of_operation[2] << 660
                store.hours_of_operation[2] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[3] << 660
                store.hours_of_operation[3] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[4] << 660
                store.hours_of_operation[4] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[5] << 660
                store.hours_of_operation[5] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[6] << 570
                store.hours_of_operation[6] << 1320

                store.save 
            end

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