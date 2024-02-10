//
//  UIHelper.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 5/2/24.
//

import UIKit


struct UIHelper{
    
    
    //Burada fonksiyonun ici bosken in superview: UIView tarzinda bir sey ekledik.
    
    static func createThreeColumnFlowLayout(in superview: UIView) -> UICollectionViewFlowLayout {
        let width =  superview.bounds.width //telefonun genisligine gore direkt olarak genislik...
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avaliableWidth = width - (padding*2) - (minimumItemSpacing*2)
        let itemWidth = avaliableWidth/3
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize  = CGSize(width: itemWidth, height: itemWidth + 40 ) //width zaten ustte belirledik. Height kisminda da 150 yazsak olacaktir. Zaten kare bir image var ve altinda label var. Hayli hayli gotururur onlari. Zaten heigt kismina da item width diyemezsin cunku tam kare degil abi avatarin altinda label var onun altinda bosluk var. O yuzden 150 dedik. veya itemwidth + 40 falan da yazabilirsin.
        //createThreeColumnFlowLayout fonksiyonu içinde, özel bir ızgara düzeni için UICollectionViewFlowLayout oluşturulmuştur.
        
        
        return flowLayout
    }
}
