

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor =  UIColor.systemGray4.cgColor //layer nesnesinin kenarının rengini belirlemek için kullanılır.
        
        
        self.textColor = .label // Bu .label parametresi dark modda light veriyor light modda dark veriyor. Yani Standar uilabel color oluyor
        tintColor = .systemRed //Imlecin rengi galiba. Tam kavrayamadim... O yuzden red yapiyorum
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2) //Buyuk gozukmesi icin title2 Verdik.
        //NOT: BURADAK OZELLIKLERI YORUM SATIRINA FALAN AL VE OGRENMEYE CALIS NASIL CALISIYORLAR ILLAKI HEPSINI YAZMAK MI GEREKIYOR.
        adjustsFontSizeToFitWidth = true //Hocam bunun olayi sey. Cok uzun username verirsen ve eger textField'a sigmazsa onu sigacak sekilde fitlestiriyor.
        minimumFontSize = 10 //Minimumda 10 olacak sekilde ayarliyorum yoksa herif cok uzun bir sey girip ta 4 e kadar dusurur font'u uygulamayi bozar.
        self.backgroundColor = .tertiarySystemBackground //Label'in background colori ile ilgili degistirip bakabilirsin. Self'i dumenden koydum.
        autocorrectionType  = UITextAutocorrectionType.no // sadece nokta koyupta yazabilirsin boylede bu ozellik ise yazarken sacma sekilde  surekli dogrusuna cevirmeye calisiyordu biliyorsun onu no yapiyoruz ki duzeltmesin.
        
        
        keyboardType = .default
        returnKeyType = .go //Burada sadece return button yerine go yazmasini sagladik. Henuz bu go key'inin hooked it yapmadik yani baglamadik yani ne yapacagini soylemedik.
        //Bundan sonra bunu yapacagiz.
        
        
        
        placeholder = "Enter a username"
        

    }
    
}
