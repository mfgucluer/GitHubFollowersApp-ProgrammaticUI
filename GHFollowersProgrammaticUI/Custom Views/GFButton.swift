//
//  GFButton.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 13/12/23.
//

import UIKit

class GFButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //Not: Eger sadece custom initializer yapacaksak biliyorsunku overRide Init fonkiyonuna ihtiyacimiz yok abi... Bu override olayi viewControllerin icinde de var. overRidefunc viewdidLoad var orada da ve tabi ki onun icinde de super var.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //Storyboard kullanmadigimiz icin bu kismi yazmamiz gerekiyor sanirsam.
        /*
         -----------------------------Fonksiyonun Aciklamasi------------------------
         Bu kod örneği, bir özel UIButton alt sınıfı olan GFButton'ı tanımlar. `init(coder:)` fonksiyonu, bu özel sınıfın örneklerini oluştururken arayüz tasarımını (`Storyboard` veya `XIB` dosyaları üzerinden) kullanıldığında devreye girer. Bu fonksiyon, `NSCoder` aracılığıyla yapılandırma bilgilerini kullanarak bir örneği başlatma görevini üstlenir.

         Şu iki özel durum dışında genellikle bu fonksiyonun içine bir şeyler eklenmez:
         1. **Storyboard veya XIB ile Kullanım:**
            - Eğer `GFButton`'ı bir Storyboard veya XIB dosyasında arayüz tasarımı yaparken kullanacaksanız, `init(coder:)` fonksiyonu gereklidir. Bu, arayüz tasarımınızda yer alan bileşenleri (örneğin, UIButton'ı) `GFButton` ile ilişkilendirmenizi sağlar.

         2. **Programmatic Kullanım:**
            - Eğer sadece programmatik olarak `GFButton` örnekleri oluşturacaksanız ve arayüz tasarımını kullanmayacaksanız, `init(frame:)` fonksiyonu yeterlidir. Ancak, genellikle Swift dilinde `init(coder:)` fonksiyonunu sağlamak iyi bir uygulama pratiğidir.

         Yukarıda bahsettiğiniz gibi, eğer sadece programatik olarak kullanacaksanız ve storyboard veya XIB kullanmıyorsanız, `init(coder:)` fonksiyonunu tanımlamak zorunda değilsiniz. Ancak, bu fonksiyonu tanımlamış olmak, gelecekte arayüz tasarımına ihtiyaç duyulduğunda uyumluluk sağlar. Eğer sadece programatik olarak kullanacaksanız ve bu fonksiyonu kullanmayacaksanız, içeriğini boş bırakabilir veya `fatalError` ile implement ettiğiniz gibi bir hata durumu ekleyebilirsiniz.
         */
    }
    
    
    // Custom initialize methodumuzu olusturuyoruz.
    init(backGroundColor: UIColor, title: String){
        super.init(frame: CGRect.zero) //Usta daha sonradan belirleyecegimizi icin frameleri bunu burada 0 yapiyoruz. Buttona gore belirleyecegiz sonucta.
        self.backgroundColor = backGroundColor //Burada self'i ister yaz ister yazma ancak tabi ki buradaki self bu button'u temsil eder ve onun attribute'u backgroundColor'u temsil eder. Isimler benzer oldugu icin yaziyoruz. eger tamamen ayni isimleri yapsaydi kesinlikle yazmak zorunda kalacaktik.
        //Simdi hocam title'i burada zaten bir string olarak aliyorsun. Onun icin bunu bu buttona set etmen gerekecektir. Onun icin setTitle methodunu kullanman gerekiyor
        self.setTitle(title, for: UIControl.State.normal) //Burada da ister self'i yaz ister yazma abi self zaten bizim butonumuzu temsil edecek. Yazmak daha şık duracaktir. Buradaki ControlState ise buttonun o andaki durumunu belli ediyor. Mesela bunu highlighted falan da yapabilirsin.
        configure()
        
    }
    
    

    //Not: Buradaki private sozcugu ile bu fonksiyonun baska yerlerde GFButton initialize edilse bile erisim saglanamaz ozelligini veriyoruz.
    private func configure(){
        
        //titleLabel--->>> bu titleLabel direkt buttonun kendisine bagli bir attribute. Ustune zaten optionla gelince ne oldugunu anlayabilirsin.
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) //Bu ozellik kullanicinin telefon ayarindaki fontuna gore app'in fontununun ayarlanmasini sagliyor diye anlaadim. Oradaki headline olayida textStyle'i zaten. Bunun gitHubta bir reposu var oraya kaydettim.
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.black, for: UIControl.State.highlighted)
        /*
         Evet, `GFButton` sınıfında `layer.cornerRadius = 10` gibi kodları direkt olarak yazabilirsiniz çünkü `UIButton` sınıfı, `CALayer` sınıfından türemiştir ve bu özelliklere erişim sağlamak için `layer` özelliğini kullanabilirsiniz. Dolayısıyla, bu kod doğrudan `GFButton` sınıfının içinde tanımlandığı için, `GFButton`'un özel bir özelliği olarak kabul edilir.

         `UIButton` sınıfı, `CALayer` özelliklerini barındıran bir sınıftır ve bu özelliklere `UIButton` üzerinden erişebilirsiniz. Bu nedenle, `layer.cornerRadius = 10` gibi bir kod yazarak, `GFButton` sınıfının köşe yarıçapı özelliğini doğrudan tanımlamış olursunuz. Bu durumda, `GFButton` sınıfının köşe yarıçapı özelliği, `UIButton`'ın içinde bulunan `CALayer`'a ait bir özellik olarak kabul edilir ve `GFButton` sınıfı bu özelliğe erişim sağlar.

         Bu şekilde, `UIButton` sınıfının sunduğu genel özelliklere ve özel olarak `GFButton` sınıfına eklediğiniz özelliklere, sınıfın içinde doğrudan erişebilir ve bunları kullanabilirsiniz.
         CALayer, Core Animation Layer'ın kısaltmasıdır. Core Animation, Apple'ın iOS ve macOS platformlarında kullanılan bir grafik ve animasyon framework'üdür. CALayer, Core Animation'ın temel yapı taşlarından biridir ve bir grafik katmanı olarak düşünülebilir.
         */
        
    }
    
    
    
    
}
