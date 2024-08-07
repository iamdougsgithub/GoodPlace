# Core Dizini

Bu dizin tüm uygulama içerisinde kullanıcalacak olan componentler'i içerir.

## Dosya Yapısı

### assets
Uygulama içerisinde kullanılan resimler, animasyonlar ve fontları içerir.



### constants
Uygulama içerisinde padding,border radius ve enum gibi sabit olarak kullanılacak değerleri içeir.

#### * `asset_path_enum.dart`
Uygulamada kullanılan asset'lerin path'lerini kolayca kullanabilmek için oluşturuldu.

// **!NOT!** : Bu enum sadece `app_assets.dart`dosyası içerisinde erişilebilir.

#### * `app_assets.dart`

#### * `app_border_radius.dart`

#### * `app_paddings.dart`

### extensions 
Tüm uygulamada kullanılacak *extension*'ları içerir.
#### `context_extension.dart`
* Bu extension'u kullanarak contexte'bağlı olan bazı metodları context.{method} ile kullanabiliriz.
 ##### İçerik
`theme => Theme.of(this)`

`textTheme => Theme.of(this).textTheme`

` mediaQuery => MediaQuery.of(this)`

`screenSize => mediaQuery.size`

`keyboardSize => mediaQuery.viewInsets.bottom`

`dynamicWidth`

`dynamicHeight` 

`navigator => Navigator.of(this)` 

*Örnek*: 
* Theme'e ulaşmak için `Theme.of(context).theme` yerine `context.theme` kullanbiliriz.
* MediaQuery için `MediaQuery.of(context)` yerine `context.mediaQuery` kullanbiliriz.

### resources
Tekrar tekrar kullanılacak olan servisleri içerir.
#### `error_texts.dart`
Uygulamada kullanıcının karşılacabileceği hataları, kullanıcınının anlayabileceği şekilde ona göstermek için `AppErrorText` class'ını kullanıyoruz.

##### Kullanım Şekli
```
  try {
  data = someMethod();
  }catch(errorCode){
   print(AppErrorText.errorMessageConverter(errorCode))
  }
```
#### `firebase_utils.dart`

Bu class'ın kullanım amacı Firebase'de genel olarak kullandığımız instance'lara
daha kolay bir şekilde ulaşmak

 ##### İçerik
 `firestore = FirebaseFirestore.instance`

 `firebaseAuth = FirebaseAuth.instance`

 `User? get currentUser => firebaseAuth.currentUser`

`storage = FirebaseStorage.instance`
##### Kullanım Şekli
```
 class SomeFirebase extends FirebaseUtils{
 addCollection(){
   firestore.collection('collectionPath');
 }
 authMethod(){
 firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
 }
 }
```

### utils
Uygulamada ortak olarak kullanılacak olan widget,model,mixin gibi dosyaları içerir.

