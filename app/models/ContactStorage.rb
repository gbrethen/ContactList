require 'json'
class ContactStorage
    @@fileName = "contact_list.json"
    @@errorFileName = "errors.txt"
    @@path = Rails.root
    @@errorFile = "#{Rails.root}/#{@@errorFileName}"
    @@filePath = "#{@@path}/#{@@fileName}"
    @@errorPath = "#{@@path}/#{@@errorFileName}"
       
    def initialize
                
        if not File.exists?(@@errorPath) then
            File.new(@@errorPath, 'w')
        end
            
        if not File.exists?(@@filePath) then
            File.new(@@filePath, 'w')
        end
    end
            
    def FilePath
        return "#{@@path}/#{@@fileName}"
    end
	        
    def CreateFile(txt)
        #puts "obj: #{obj}"
        #puts "json: #{obj.to_json}"
        if not File.exists?(@@filePath) then
            File.open(@@filePath, 'w') do |f| 
                f.write(txt)
            end
        end
    end
        
    def ReadFromFile
        return File.read(@@filePath) 
    end
        
    def WriteToFile(txt)
        File.open(@@filePath, 'w') do |f|
            f.write(txt)
        end 
    end
        
    def FileExists
        return File.exists?(@@filePath)
    end
end