db.customer.update({},{$set: {"phone": "897907979" } } , false , true )

//@undo

db.customer.update({},{$unset: {"phone": 1}},false,true)
