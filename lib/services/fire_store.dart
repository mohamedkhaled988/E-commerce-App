import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/models/product.dart';

class FireStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(KProductCollection).add({
      KProductName: product.PName,
      KProductprice: product.PPrice,
      KProductDescription: product.PDescribtion,
      KProductCategory: product.PCategory,
      KProductLocation: product.PLocation,
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore
        .collection(KProductCollection)
        .snapshots(); //دي عبارة عن stream كأنك حاطط ودنك معاها اول ما يحصل تغيير تبدأ تنبهك
  }
  deleteProduct(documentId) {
    _firestore.collection(KProductCollection).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore.collection(KProductCollection).doc(documentId).update(data);
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore
        .collection(KOrders)
        .snapshots(); //دي عبارة عن stream كأنك حاطط ودنك معاها اول ما يحصل تغيير تبدأ تنبهك
  }

  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return _firestore
        .collection(KOrders)
        .doc(docId)
        .collection(KOrderDetails)
        .snapshots();
  }



  storeOrders(data, List<Product> products) {
    var documentRef = _firestore
        .collection(KOrders)
        .doc(); // ده عبارة عن ref يستخدم لتخزين الداتا
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(KOrderDetails).doc().set({
        KProductName: product.PName,
        KProductCategory: product.PCategory,
        KProductprice: product.PPrice,
        KProductQuantity: product.PQuantity,
        KProductCategory : product.PCategory ,
      });
    }
  }
}
