class CsvImportUsersService
	require 'csv'

	def call(file)
		 file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ";")
    csv.each do |row|
      user_hash = {}
      user_hash[:username] = row["Username"]
      user_hash[:email] = row["Login email"]
      user_hash[:identifier] = row["Identifier"]
      user_hash[:first_name] = row["First name"]
      user_hash[:last_name] = row["Last name"]
      User.create(user_hash)
    #    byebug
    # binding
    #   p row
	end
end
end