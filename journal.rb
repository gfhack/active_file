class Journal
   include ActiveFile
 
 	field :title, required: true
 	field :value, default: 10.0
end