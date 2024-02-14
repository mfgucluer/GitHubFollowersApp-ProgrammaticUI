//
//  GFTitleLabel.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 18/12/23.
//

import UIKit

class GFTitleLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init (textAligment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold) //Burada bold seciyoruz cunku bizim title'lar her zaman bold olacak.
        configure()
        
        
    }
    
    
    private func configure(){
        textColor = .label //burada .label olayi dark modda falan beyaz oluyor iste light modda siyah oluyor labelimizi.
        adjustsFontSizeToFitWidth = true // biliyorsun bunu oraya sigmazsa fontu kucultecek.
        minimumScaleFactor = 0.90 //shrink olacak tabi ki ama en fazla 0.90 olacak sekilde
        lineBreakMode = .byTruncatingTail //.byTruncatingTail kullanıldığında, eğer metin sığmazsa, metnin sonundaki kısmı kesilir ve bir üç nokta (...) eklenir. Bu, metni tamamen göstermek yerine bir kısmını gösterip geri kalanını kesip üç nokta ile ifade etmek için kullanılır.
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    
    
}
