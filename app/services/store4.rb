require 'json'
require 'open-uri'

class Store4 
    def products
        products = open(ENV['lcbo_store4_key'])
        products_data = JSON.parse(products.read)

        products_data["result"].each do |product|

            new_product = Product.new(name: product["name"], variety: product["varietal"], style: product["style"])
            new_product.alcohol_content = product["alcohol_content"]
            new_product.price_in_cents = product["price_in_cents"]
            new_product.producer_name = product["producer_name"]
            new_product.serving_suggestion = product["serving_suggestion"]
            new_product.flavor_profile = product["tasting_note"]
            new_product.image = product["image_thumb_url"]

            store = Store.find_by(name: "Danforth & Broadview")
            
            if store == nil 
                store = Store.new(name: "Danforth & Broadview")
                store.address_line_1 = "200 Danforth Avenue"
                store.address_line_2 = nil 
                store.city = "Toronto"
                store.zipcode = "M4K1N5"
                store.phone_number = "(416) 469-4724"
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
                store.hours_of_operation[2] << 570
                store.hours_of_operation[2] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[3] << 570
                store.hours_of_operation[3] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[4] << 570
                store.hours_of_operation[4] << 1320

                store.hours_of_operation << []
                store.hours_of_operation[5] << 570
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