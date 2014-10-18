require File.expand_path("shop")

journal = Journal.new title: "PHP"
journal.save
journal.destroy
