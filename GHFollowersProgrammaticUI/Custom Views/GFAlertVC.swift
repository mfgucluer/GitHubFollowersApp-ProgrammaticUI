  //
//  GFAlertVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 18/12/23.
//

import UIKit

class GFAlertVC: UIViewController {

    //Aga anladigim kadariyla burada sean Abi bize tamamen custom bir dikdortgen olusturmayi gosteriyor.
    
    let containerView = UIView() //UIView class  = rectangular are in the screen
    let titleLabel = GFTitleLabel(textAligment: NSTextAlignment.center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAligment: .center)
    let actionButton = GFButton(backGroundColor: UIColor.systemPink, title: "OK")
    
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    
    let padding0: Int = 20
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //view.backgroundColor = .white  -->> Mesela bu sekilde yaparsan direktman arka bembeyaz cikar. burada arkayi karartili sekilde cikariyoruz biz. Yani searchVC miz arkada hala gorunur sekilde...
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)//Buradaki kod bize %75 opacity olarak bir backGround olusturmamizi saglayacak.
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureBodyLabel()
        
        }
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemBackground
        containerView.layer.borderWidth = 2 //Kenarlarin genisligi
        containerView.layer.borderColor = UIColor.white.cgColor// UIKit ve Core Graphics (Quartz) kütüphaneleri arasındaki tür uyumsuzluğu çözmek için. borderColor özelliği bir UIColor türü beklerken, layer sınıfı içindeki bu özellik bir CGColor türü bekler.
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Rectangleimizia constraint verecegiz yani ekranda nerede durmasi gerektigini soyleyecegiz. Direkt zaten ortada duracak. height ve width verdik.
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
            
        
        
        
        ])
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel) //Burada dogal olarak view'a degil containerView'a yani olusturdugumuz rectangle'a ekleme yapiyoruz.
        titleLabel.text = alertTitle ?? "Something went wrong"// Iste neden o variablelari olusturdugumuz aslinda...
        
        
        //Simdi title'in rectangle icindeki constraintlerini verecegiz.
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),//padding is variable that we just created up there.
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(padding0)), //LEFTTEN not: burada CGFloata donusturebildigimizi soyluyorum.
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding), //RIGHTTAN
            
            //Not: padding yazan yerlere direkt sayi da yazabilirsin. Sean abim bunu gostermek istedi sadece. Sean Abime laf yok aga....
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        
        ])
        
    }
    
    func configureButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: UIControl.State.normal)
        //Hocam simdi kendi urettigin button'a cok fazla cancelmis bilmemneymis eklemen maliyet. O yuzden bu turlu durumlarda apple'inkini kullanacaksin. Burada anlamadigim nokta apple'in alert gosterimini configure edemiyormuyuz acaba? Bakmak lazim
        //Simdi ok buttonuna tiklayinca ne olacagini yazmak icin target ekleyecegiz.
        actionButton.addTarget(self, action: #selector(dismissVC), for: UIControl.Event.touchUpInside)
        
        NSLayoutConstraint.activate([
        
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
            
        
        
        
        ])
        
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
        
    }
    
    
    func configureBodyLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        
        
        
        
        
        ])
        
    }
    

    

}
