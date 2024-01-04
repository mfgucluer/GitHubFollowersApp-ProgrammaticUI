//
//  NetworkManager.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 19/12/23.
//

import Foundation




//extension Follower: Decodable {}

// Hocam boyle de yapabilirsin Follower dosyasindaki gibi de yapabilirsin...

/*
 
 Tabii ki, `extension Follower: Decodable {}` satırının anlamını daha basit bir şekilde açıklayayım.

 Swift dilinde, `Decodable` protokolü, bir tipin JSON formatındaki verileri alabilmesi ve bu verileri tipine dönüştürebilmesi için kullanılır. Bu protokolü uygulayan bir tip, `JSONDecoder` ile JSON verilerini o tipte bir nesneye dönüştürebilir.

 Şimdi, `Follower` struct'ını düşünelim. Bu struct, GitHub takipçilerini temsil ediyor. Ancak, bu struct'ın, `Decodable` protokolünü doğrudan uygulaması gerekir ki, `JSONDecoder` bu struct'ı kullanarak JSON verilerini bu struct'a dönüştürebilsin.

 Ancak, direkt olarak `Follower` struct'ına `Decodable` protokolü eklemek bazen uygun olmayabilir (örneğin, eğer başka bir modülde bulunan bir tipi genişletmek istiyorsak). Bu durumda, Swift dilinde `extension` kullanarak, mevcut bir tipin (`Follower` struct'ı) üzerine sonradan ek bir özellik veya protokol ekleyebiliriz.

 Bu yüzden `extension Follower: Decodable {}` satırı, `Follower` struct'ına, `Decodable` protokolünü uygulayan bir ek özellik ekler. Böylece, `Follower` struct'ı artık `Decodable` protokolünü anlıyor ve `JSONDecoder` ile kullanılabiliyor.
 */




class NetworkManager {
    
    static let sharedd = NetworkManager()
    //every network managerda bu static let shared olmasi gerekn bir degisken.
    /*
     `static let shared = NetworkManager()` ifadesinde `static` kullanılmasının nedeni, bir Singleton tasarım deseni oluşturmak içindir. Singleton deseni, bir sınıfın yalnızca bir örneğini (instance) oluşturmasına ve bu örneğe genel erişim sağlamasına olanak tanır.

     Bu durumda, `NetworkManager` sınıfının `shared` adında bir özel özelliği (property) var ve bu özellik, `NetworkManager` sınıfının yalnızca bir örneğini içerir. `static` kelimesi, bu özelliğin sınıfa ait olduğunu ve sınıf düzeyinde bir özellik olduğunu belirtir. Bu da demek oluyor ki, `NetworkManager` sınıfının bir örneği oluşturulduğunda, bu örneğe `shared` adıyla ulaşabilirsiniz ve bu örnek tüm uygulama boyunca tek bir örnek olarak paylaşılır.

     Örneğin:

     ```swift
     let myNetworkManager = NetworkManager.shared
     ```

     Bu, `NetworkManager` sınıfından yalnızca bir örnek oluşturulmasına ve bu örneğe her yerden erişilebilmesine olanak tanır. Singleton deseni genellikle kaynakları paylaşma, tek bir noktadan yapılandırma yönetimi gibi durumlarda kullanılır.
     */
    
    
    let baseURL = "https://api.github.com/users/" //gitHub apisinin temel url dir bu.
    

    
    private init(){
        //NetworkManager sınıfının private bir initializer'ı bulunuyor. Bu, bu sınıftan başka bir örneğin oluşturulmasını engeller ve singleton tasarım desenini uygular. Bunu private olarak yapmazsan defaultta internal olarak gelir ve baska yerlerde networkManager sinifindan nesne olusturularak ayri ve farkli yerlerde baska nesnelerle erisim saglanabilir. Bu singleton yapisina aykiri bir durum.. Yani private kullanmazsan daha genis bir erisim izni vermis oluyorsun bu durumda Singleton tasarim desenini korumani zorlastirir.Singleton tasarım deseni, bir sınıfın yalnızca bir örneğine sahip olması ve bu örneğin genel bir erişim noktası olması prensibine dayanır.
    }
      
    
    
    //Buradaki kod bir tane singleton yaratir.
    
    //simdi fonksiyonumuzu yazacagiz.
    //escape den sonra network call islemi tamamlandiginda biliyorsun Follower array return edecegiz dogal olarak. O yuzden [Follower] yaziyoruz. Ve bunlari optional yapiyoruz cunku gelmeyebiliriler.
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower],GFError>) -> Void) {
        //Buradaki escapingin anlami completed parametresinin bir fonksiyon gibi disarida cagirabilmek... fonksiyonun icinde for kullanilmasini sebebide galiba username ve page'i es gecebilmek benim anladigim.
        
        
        //Burada zamani gelicek bir API icn 100 tane request atacaksin ve bunun icinde bir base url olur cogu zaman. Daha sonra spesifik urlyi alirsin. Burada da onu yapiyoruz. Daha sonrada follower Url 'i ekliyoruz.
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //Swiftte URL type oldugu icin yukaridaki olayi URL objecte cevirmemiz gerekiyor.
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidUsername))
            return
            //endpoint string'i kullanılarak bir URL oluşturuluyor. Eğer bu işlem başarısız olursa, completed closure'ı çağrılarak hata mesajı ile birlikte nil değeri döndürülüyor.
            /*
             `guard let url = URL(string: endpoint) else { ... }` bloğu, bir güvenlik kontrolü yapar ve `URL(string:)` fonksiyonunun dönüş değerini optional bir `URL` nesnesine çevirir. Eğer bu dönüş değeri `nil` ise (yani, URL oluşturulamamışsa), `else` bloğu çalışır. Bu blok içinde `completed` closure'ı çağrılarak bir hata mesajı ve `nil` değeri ile birlikte fonksiyondan çıkılır.

             Şimdi, `return` ifadesinin kullanılma nedenine bakalım:

             ```swift
             return
             ```

             Bu ifade, fonksiyondan çıkışı belirtir. Eğer `URL` oluşturulamazsa, fonksiyonun geri kalan kısmına geçmeden doğrudan fonksiyondan çıkılır. `return` ifadesinden sonra herhangi bir şey yazılmamış olmasının sebebi, `else` bloğundan çıkıldığında geri kalan işlemlerin zaten çalıştırılmamasıdır.

             Yani, eğer `URL` oluşturulamazsa, fonksiyonun geri kalan kısmı gereksizdir ve `return` ifadesi ile fonksiyondan çıkılır. Bu, gereksiz işlemlerin yapılmadan fonksiyonun sonlandırılmasını sağlar ve performans açısından etkili bir kod yazımını temsil eder.
             */
        }
        
        
        
        
        
        //URLSession kullanılarak bir asenkron veri gönderme işlemi başlatılıyor. Bu işlem, GitHub API'sinden takipçi verilerini almak için kullanılır.
        /*
         
         Bu kod satırı, URLSession.shared.dataTask(with:completionHandler:) fonksiyonunu kullanarak bir ağ isteği oluşturur. Bu istek, belirtilen URL üzerinden bir veri almayı amaçlar.

         URLSession.shared: URLSession sınıfının paylaşılan bir örneğini kullanarak ağ işlemlerini yönetmeye olanak tanır. shared özelliği, uygulama genelinde kullanılan bir URLSession örneğini ifade eder.

         dataTask(with:completionHandler:): Belirtilen URL'ye bir ağ isteği başlatan fonksiyondur. Bu istek asenkron olarak çalışır, yani isteğin tamamlanması beklenmez, diğer kod satırları çalışmaya devam eder. İstek tamamlandığında, bir kapanış (closure) çalıştırılır.

         url: Yapılan ağ isteğinin hedef URL'sini temsil eder. Önceki satırlarda oluşturulan guard let url = URL(string: endpoint) else { ... } bloğunda kontrol edilen ve oluşturulan URL bu kısımda kullanılır.

         completionHandler: Ağ isteği tamamlandığında çalıştırılacak kapanıştır. Bu kapanış, üç parametre alır: data, response, ve error. Bu parametreler, sırasıyla, istek sonucunda alınan veriyi, sunucudan gelen yanıtı ve herhangi bir hata durumunu temsil eder.
         */
        let task = URLSession.shared.dataTask(with: url) {data, response, error in



            // if letten sonra _ kullanmamizin nedeni: hatanın kendisine ihtiyaç duymuyoruz, sadece hatanın olup olmadığını kontrol ediyoruz.
            if let _ = error{
                completed(.failure(.unabletoComplete))
                /*
                 Bu ifadenin amacı, eğer error değeri nil ise (yani herhangi bir hata oluşmamışsa), completed closure'ını çağırarak işlemi tamamlamaktır.
                 completed fonksiyonu, asenkron bir işlemin sonucunu bildiren bir closure'dır. İlk parametre olarak [Follower]? tipinde bir dizi (takipçi listesi) veya nil değeri alır, ikinci parametre olarak ise bir hata mesajı alır. Eğer hata oluşmuşsa, nil değeri verilir ve hata mesajı belirtilir.
                 Yani, bu kod bloğu, ağ isteği yapılırken olası bir hatayı kontrol eder. Eğer herhangi bir hata oluşmuşsa, completed closure'ını çağırarak işlemi tamamlar ve hatayı bildirir. Eğer hata oluşmamışsa, error değişkenini kullanmadan devam eder.
                 */
                return
            }
            
            //Eğer server'dan gelen yanıt HTTPURLResponse tipinde değilse veya yanıtın durum kodu 200 (Başarılı) değilse, completed closure'ı çağrılarak hata mesajı ile birlikte nil değeri döndürülüyor.
            //Bu kod bloğu, HTTPURLResponse sınıfından gelen response nesnesini kontrol eder ve HTTP durum kodunun 200 olup olmadığını kontrol eder. HTTP durum kodları, bir HTTP isteğinin sonucunu tanımlayan sayısal değerlerdir. Genellikle, başarılı bir isteği belirtmek için 200 kodu kullanılır.
            //Bu kontrol, sunucudan alınan yanıtın başarılı bir yanıt olduğunu belirlemeye yöneliktir. Kod şu şekilde çalışır:
            
           // guard let response = response as? HTTPURLResponse: Bu satır, response değişkenini bir HTTPURLResponse türüne dönüştürmeye çalışır. Eğer bu dönüşüm başarılıysa, yani response bir HTTPURLResponse objesi ise, kontrol devam eder. Aksi takdirde (dönüşüm başarısızsa), else bloğuna girer ve işlem burada sona erer.Bu kontrolün amacı, sunucudan gelen yanıtın (response) bir HTTPURLResponse objesi olup olmadığını kontrol etmek ve durum kodunun 200 olup olmadığını kontrol etmektir.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            
            
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            //decoder serverdan veriyi alacak ve objemize decode edecek. Encoder ise objemizi alacak ve veriye(dataya) donusturecek...
            
//            Eğer yukarıdaki kontrollerden geçilirse, JSONDecoder kullanılarak server'dan gelen JSON verileri Follower struct'ına dönüştürülüyor. Eğer dönüştürme başarılı olursa, completed closure'ı çağrılarak takipçi verileri ile birlikte nil değeri döndürülüyor. Eğer bir hata oluşursa, yine completed closure'ı çağrılarak hata mesajı ile birlikte nil değeri döndürülüyor.

            /*
             Tabii ki, aşağıda verdiğiniz kod bloğunu adım adım açıklayalım:

             ```swift
             do {
                 // JSONDecoder nesnesi oluşturuluyor.
                 let decoder = JSONDecoder()
                 
                 // JSON'da kullanılan anahtarları, Swift property'lerine uygun hale getirmek için kullanılır.
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 
                 // Veriyi Follower struct'ına dönüştürmek için JSONDecoder kullanılıyor.
                 // data: Veri, followers: Follower türündeki dizi
                 let followers = try decoder.decode([Follower].self, from: data)
                 
                 // Aşağıdaki kod, başarıyla dönüştürülmüş olan takipçileri completionHandler'a iletiyor.
                 completed(followers, nil)
             } catch {
                 // Eğer JSON dönüştürme işlemi başarısız olursa (hata oluşursa),
                 // completionHandler'a nil (başarısızlık durumunu belirten) ve bir hata mesajı gönderiliyor.
                 completed(nil, "The data received from the server was invalid. Please try again.")
             }
             ```

             Bu kod bloğu şu işlemleri gerçekleştirir:

             1. `JSONDecoder` nesnesi oluşturuluyor. Bu nesne, JSON verisini Swift nesnelerine dönüştürmek için kullanılır.

             2. `decoder.keyDecodingStrategy = .convertFromSnakeCase`: Bu satırda, JSON verisindeki anahtarları (keys) Camel Case'den Snake Case'e dönüştürme stratejisi belirleniyor. Örneğin, "followerName" şeklindeki bir anahtar Camel Case iken, "follower_name" şeklindeki bir anahtar Snake Case'dir. Bu ayar, JSON verisindeki Snake Case anahtarlarını Swift'teki Camel Case property'lerine otomatik olarak dönüştürür.

             3. `let followers = try decoder.decode([Follower].self, from: data)`: Bu satırda, JSON verisinin dönüştürülmesi gerçekleştiriliyor. `decode` fonksiyonu, belirtilen türdeki (`[Follower].self`), JSON verisini Swift nesnelerine dönüştürür. Eğer dönüştürme başarılı olursa, takipçileri içeren bir dizi elde edilir.

             4. `completed(followers, nil)`: Bu satırda, dönüştürme işlemi başarılı olduğu için `completed` closure'ına, dönüştürülmüş takipçi dizisi ve `nil` değeri gönderilir. Bu, işlemin başarıyla tamamlandığını belirtir.

             5. `catch` bloğu: Eğer `do` bloğu içindeki herhangi bir adımda bir hata oluşursa, `catch` bloğu çalışır. Bu durumda, `completed` closure'ına `nil` (başarısızlık durumunu belirten) ve bir hata mesajı gönderilir. Bu, JSON dönüştürme işleminin başarısız olduğunu belirtir.

             6. `task.resume()`: En sonunda, asenkron veri gönderme işlemi başlatılır. Bu, önceden tanımlanan ağ isteğini yürütmek için kullanılır.

             Bu kod bloğu genellikle bir ağ isteğinden alınan JSON verisini Swift nesnelerine dönüştürme işlemini gerçekleştirir ve dönüştürme başarılıysa bu veriyi işlemek üzere bir closure'a iletilir. Eğer dönüştürme başarısız olursa, hatayı belirten bir mesaj iletilir.
             */

            do {
                let decoder = JSONDecoder() // JSONDecoder nesnesi oluşturuluyor.

                decoder.keyDecodingStrategy = .convertFromSnakeCase     // JSON'da kullanılan anahtarları, Swift property'lerine uygun hale getirmek için kullanılır.

                // Veriyi Follower struct'ına dönüştürmek için JSONDecoder kullanılıyor.
                    // data: Veri, followers: Follower türündeki dizi
                let followers = try decoder.decode([Follower].self, from: data)
                
                // Aşağıdaki kod, başarıyla dönüştürülmüş olan takipçileri completionHandler'a iletiyor.
                    /*
                     Bu kod, `completed` adlı bir closure'ı çağırıyor. `completed` closure'ı, ağ isteğinin başarıyla tamamlandığını ve alınan veriyi (takipçilerin listesi) iletmek için kullanılır. Ayrıca, bu closure'a hata durumunda `nil` değeri ve bir hata mesajı da iletilir.

                     ```swift
                     completed(followers, nil)
                     ```

                     Burada:
                     - `followers`: Başarıyla dönüştürülmüş olan takipçilerin listesini temsil eder. Eğer işlem başarılı olduysa, bu değer `nil` olmayacak ve takipçilerin listesini içerecektir.
                     - `nil`: Bu, işlemin hata olmadığını (başarılı olduğunu) belirtmek için kullanılır. Eğer bir hata durumu olsaydı, bu parametre `nil` olmazdı, onun yerine bir hata mesajı içerirdi.

                     Yani, bu kod satırı, ağ isteğinin başarıyla tamamlandığını ve alınan veriyi (takipçilerin listesi) `completed` closure'ına ilettiğini belirtir. Eğer hata oluşmuş olsaydı, `completed` closure'ına hata durumunu belirten bir mesaj iletilirdi.
                     */
                completed(.success(followers))
                
            } catch {
                // Eğer JSON dönüştürme işlemi başarısız olursa (hata oluşursa),
                    // completionHandler'a nil (başarısızlık durumunu belirten) ve bir hata mesajı gönderiliyor.
                completed(.failure(.invalidData))
            }
        }
        
        task.resume() //Asenkron veri gönderme işlemi başlatılıyor. Yani network call islemini baslatan komuttur bu unutmamak gerekiyor.
        
        
        
        
        

        
    }
    


    }

