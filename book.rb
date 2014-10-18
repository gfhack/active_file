class Book
   include ActiveFile

   field :title, required: true
   field :pages, required: true
   field :isbn, required: true
   field :category, required: true
   field :value, default: 40.00
   field :author, required: true
end
