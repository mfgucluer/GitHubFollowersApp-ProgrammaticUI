//
//  GFAvatarImageView.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 5/1/24.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.sharedd.cache //cache icin bir variable olusturduk derhal burada kullanmak icin. Surekli bunu yazmamak icin tabiki..
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true //Kenarlari yumusatmak icin galiba. Yani, görünümün sınırlarının dışına taşan alt görünümler veya çizimler görsel olarak kesilecektir. Örnek olarak, bir UIImageView içinde büyük bir resim varsa ve clipsToBounds değeri true olarak ayarlanmışsa, resmin görünüm sınırları dışında kalan kısımları gösterilmeyecektir. Bu, genellikle tasarım düzeni veya görsel düzenleme açısından faydalı olabilir.
        
        //simdi celldeki image download edilemezse elbette bos square yerine bir placeHolder image gostermemiz gerekiyor. Bunun icin assest dosyamizdaki gitHub logomuzu kullanabiliriz.
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    //download isleminide bu class ta yapcagizmi icin tekrar buraya gelecegiz.
//Bu arada avatar cekme isini burada yapiyoruz network managerda degil sebebide galiba placeholder avatarlarin burada olmasi ve onun icin hata ayiklama islemi yapmayacak olmamiz.
    func downloadImage(from urlString: String){
        
        
        let cacheKey = NSString(string: urlString) //altta for key icin ns string istiyor ondan burada ceviriyoruz.
        
//cachekey her avatar icin unique bir url aslinda...
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return   //burada return yapiyoruz cunku eger image'i cachelediysek herhangi bir network call yapmamiza gerek yok. eger yapamazsak asagida download image islemini yapiyoruz. buranin mantigini tam anlayamadim. Ancak kendi appimizi yazarken anlariz heralde.
        }
        
        
                    
        
        //simdi burada url i cekerken hata ayiklama islemi yapmiyoruz yani onlem almiyoruz bunun sebebi gerek yok. Image download edilemzese zaten placeHolder imagelarimiz gosterilmeye devam edecektir. ayrica collection view gosterilirken mesela senin 12 takipcin var 12 tane hata gostermek tarzinda popup cikarmak hos olmayacaktir. Yani placeholderlar error messagelari convey edecek....
        
        //Burada network manager da yaptigimiz seyleri tekrarliyoruz... Sadece error handling daha az yapiyoruz nispeten..
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else {return} // weak self konusunda konusmustuk aslinda bunun aciklamasi var  follower list vc de weak self koyunca yukari selfleri ? optional yapmamiz gerekioyor bundan kurtulmak icin bu kod satirni yaziyoruz.
            
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            //simdi datayi aldik datadan imageleri alabiliriz.
            
            
            //bu optional donuyor bu sebepten dolayi guard let kullandik.. network call da yanlis giden bir seyler varsa 
            guard let image = UIImage(data: data) else {return}
            
            
            self.cache.setObject(image, forKey: cacheKey)// burada image'i cache e set ediyoruz sanirim... Yukarida da eger cachede varsa imagelar oyle cekiyoruz ve birdaha download etmiyoruz surekli surekli. benim anladigim bu.. Yani burasi 1 kere calismis oluyor.
            
            
            
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            
            
            
            
        }
        
        task.resume()
    }
    
    
    
    
    
}

