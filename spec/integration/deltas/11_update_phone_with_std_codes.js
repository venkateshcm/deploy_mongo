db.customer.find({}).forEach(update_phone);
function update_phone(doc){ 
    doc.phone = "+91" + doc.phone; 
    db.customer.save(doc);
}

//@undo

db.customer.find({}).forEach(update_phone);

function update_phone(doc){ 
	doc.phone = doc.phone.substring(3); 
	db.customer.save(doc);
}

