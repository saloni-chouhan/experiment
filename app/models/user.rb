class User < ApplicationRecord
	include GenerateCsv
	#   require 'csv'
	# def self.to_csv(collection)
	# 	CSV.generate(col_sep: ";") do |csv|
	# 	  # csv << column_name
 #          csv << attribute_names
 #          collection.find_each do |record|
 #          	csv << record.attributes.values
 #          end
	# 	end
	# end

	validates :username,:email,:identifier,:first_name,:last_name, presence: true
end
