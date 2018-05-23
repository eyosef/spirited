class Store < ApplicationRecord
    serialize :hours_of_operation, Array
 
    has_many :products

    def remove_duplicates(store_id)
        store = Store.find_by(id: store_id)

        grouped_products = store.products.group_by{|name| name}

        grouped_products.values.map do |duplicate|
            duplicate.uniq 
        end 
    end


end
