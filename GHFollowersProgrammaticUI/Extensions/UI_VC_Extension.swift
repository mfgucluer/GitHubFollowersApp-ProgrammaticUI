//
//  UIViewControlller.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 18/12/23.
//

import UIKit
//Not: Import uikit ile ayni zamanda foundation'da import edilir.

extension UIViewController{
    func presenatGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        
        // DispatchQueue.main.async, bu işlevin ana iş parçacığında çalışmasını sağlar.

        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title:title, message:message ,buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            // Oluşturulan alertVC'nin gösterim stili ve geçiş stili belirlenir.

            
            /*
             
             Bu iki satır, bir `UIViewController`'ın gösterim (presentation) stilini ve geçiş (transition) stilini belirlemek için kullanılır. Bu durumda, `alertVC` adındaki bir view controller'ın gösterim ve geçiş stilini ayarlar.

             1. `modalPresentationStyle = .overFullScreen`: Bu, modal olarak gösterilecek view controller'ın ekranın tamamını kaplamasını sağlar. `.overFullScreen` değeri, view controller'ın arka plandaki içeriği tamamen kaplayarak, altındaki view controller'ı görünmez hale getirmesini sağlar. Bu, özellikle alert veya benzeri geçici gösterimlerde kullanışlıdır.

             2. `modalTransitionStyle = .crossDissolve`: Bu, modal olarak gösterilen view controller'ın ekrana geçişini belirler. `.crossDissolve` değeri, bir önceki view controller'ın içeriğini yavaşça solup yeni view controller'ın içeriğinin belirmesini sağlayan yumuşak bir geçiş efekti uygular. Bu, kullanıcıya daha yumuşak ve hoş bir geçiş deneyimi sunar.

             Bu iki stil, bir modal view controller'ın nasıl görüneceğini ve ekrana nasıl gelip gideceğini belirler. `alertVC` örneğinde kullanılan bu stiller, genellikle bir bildirim veya uyarı şeklindeki geçici gösterimlerde tercih edilir.
             
             */
            
            
            
            self.present(alertVC, animated: true)
            // Bu extension'ı kullanılan UIViewController üzerinde alertVC gösterilir.

             
        }
        
        
        
    }
}

