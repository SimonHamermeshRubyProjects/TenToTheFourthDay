class User<ActiveRecord::Base
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :birthday
    
    
    def self.import(file)
        CSV.foreach(file.path, headers:true) do |row|
          User.create! row.to_hash
        end
    end
  
    def self.to_csv
        CSV.generate do |csv|
          csv << column_names
              all.each do |product|
                csv << product.attributes.values_at(*column_names)
              end
        end
    end
    
end
