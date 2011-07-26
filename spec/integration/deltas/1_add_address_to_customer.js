db.customer.update({},{$set: {"address": "some address" } } , false , true );

//@undo

db.customer.update({},{$unset: {"address": 1}},false,true);
