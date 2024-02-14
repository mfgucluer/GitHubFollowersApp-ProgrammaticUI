//
//  GFBodyLabel.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 18/12/23.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init (textAligment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
        configure()
        
        
    }
    
    
    private func configure(){
        textColor = .secondaryLabel //Bu gray rengini verecektir body yazilarimiza.
        adjustsFontSizeToFitWidth = true // biliyorsun bunu oraya sigmazsa fontu kucultecek.
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping //ifadesi, bir metin öğesinin kelime bölünmesi (word wrapping) yaparak, metin sığmadığında kelimeleri kırarak alt satıra geçmesini sağlar.
        font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    

}
