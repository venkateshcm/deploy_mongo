db.customer.find({ "name" : "name_2" }).forEach(create_customer); 
function create_customer(doc){
	delete doc._id;
	doc.name = "new name"; 
	db.customer.save(doc);
}

//@undo

db.customer.remove({"name" : "new name"})
