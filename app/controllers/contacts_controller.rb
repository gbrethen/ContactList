require 'json'
require 'ContactStorage'
require 'securerandom'

class ContactsController < ApplicationController
    skip_before_action :verify_authenticity_token
    @@dataStore = ContactStorage.new
    
    def MyParser(jsonTxt)
        contact_array = []
        contact_array = JSON.parse(jsonTxt).map { |con| 
            c = Contact.new
            c.id = con['id']
            c.name = con['name']
            c.address = con['address']
            c.city = con['city']
            c.state = con['state']
            c.zip = con['zip']
            c.email_address = con['email_address']
            c.phone_number = con['phone_number']
            c
        }
        
        return contact_array
    end
    
    def index
        puts "File Exists: #{@@dataStore.FileExists}"
        if not @@dataStore.FileExists then       
            init_contact = Contact.new
            init_contact.id = SecureRandom.uuid
            init_contact.name = "John Doe"
            init_contact.address = "123 First St"
            init_contact.city = "Smyrna"
            init_contact.state = "TN"
            init_contact.zip = "37167"
            init_contact.email_address = "jdoe@gmail.com"
            init_contact.phone_number = "(615) 555-1515"
        
            txt = init_contact.to_json
            @@dataStore.CreateFile(txt)
        end
        
        @json = @@dataStore.ReadFromFile
        
        #puts "JSON is: #{@json}"
        
        contact_array = []
        contact_array = MyParser(@json)
          
        #puts "NAME: #{contact_array[0].name}"
        render json: {status: 'SUCCESS', message: 'Loaded contacts', data: 
            contact_array}, status: :ok
    end
    
    def create
        contact_array = []
        c = Contact.new
        json_string = params[:contact]
        c.id = SecureRandom.uuid
        c.name = json_string[:name]
        c.address = json_string[:address]
        c.city = json_string[:city]
        c.state = json_string[:state]
        c.zip = json_string[:zip]
        c.email_address = json_string[:email_address]
        c.phone_number = json_string[:phone_number]
        
        @json = @@dataStore.ReadFromFile
        contact_array = MyParser(@json)
        
        contact_array << c
        
        txt = contact_array.to_json
        #puts "txt: #{txt}"
        @@dataStore.WriteToFile(txt)
        
        render json: {status: 'SUCCESS', message: 'Added contact', data: "SUCCESS"}, status: :ok
    end
        
    def destroy
        contact_array = []
        @json = @@dataStore.ReadFromFile
        contact_array = MyParser(@json)
        
        contact_array.delete_if{|el| el.id == params[:id]}
        
        txt = contact_array.to_json
        #puts "txt: #{txt}"
        @@dataStore.WriteToFile(txt)
        
        render json: {status: 'SUCCESS', message: 'Removed contact', data: "SUCCESS"}, status: :ok
    end
    
end
