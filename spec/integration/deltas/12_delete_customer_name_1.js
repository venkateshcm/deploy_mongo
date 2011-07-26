db.customer.remove({ "name" : "name_1" });

//@undo

db.customer.save({"name" : "name_1", "address" : "some address" , "phone" : "+9168687868" });
