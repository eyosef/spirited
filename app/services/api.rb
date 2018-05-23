require 'json'
require 'open-uri'

class Api 

    def stores 
        stores = open(ENV['lcbo_stores_key'])
        stores_data = JSON.parse(stores.read)

        stores_data["result"].each do |store|
            unless existing_store = Store.find_by(name: store["name"])
                new_store = Store.new(name: store["name"])
                new_store.address_line_1 = store["address_line_1"]
                new_store.address_line_2 = store["address_line_2"]
                new_store.city = store["city"]
                new_store.zipcode = store["postal_code"]
                new_store.phone_number = store["telephone"]
                new_store.bilingual = store["has_bilingual_services"]
                new_store.tasting_bar = store["has_tasting_bar"]
                new_store.public_transport = store["has_transit_access"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[0] << store["sunday_open"]
                new_store.hours_of_operation[0] << store["sunday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[1] << store["monday_open"]
                new_store.hours_of_operation[1] << store["monday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[2] << store["tuesday_open"]
                new_store.hours_of_operation[2] << store["tuesday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[3] << store["wednesday_open"]
                new_store.hours_of_operation[3] << store["wednesday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[4] << store["thursday_open"]
                new_store.hours_of_operation[4] << store["thursday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[5] << store["friday_open"]
                new_store.hours_of_operation[5] << store["friday_close"]

                new_store.hours_of_operation << []
                new_store.hours_of_operation[6] << store["saturday_open"]
                new_store.hours_of_operation[6] << store["saturday_close"]

                new_store.save

            end #unless loop 
        end #each iterator
    end #stores method

end