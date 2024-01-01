//
//  SearchVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 13/12/23.
//

import UIKit



 

class SearchVC: UIViewController, UITextFieldDelegate {
    
    let logoImage = UIImageView()
    let userNameTextField = GFTextField()
    let actionButton = GFButton(backGroundColor: UIColor.systemGreen, title: "Get The Followers")
    
    
    
    var isUsernameEntered: Bool {
        return !(userNameTextField.text?.isEmpty ?? true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configureUserTextField()
        configureButton()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true) //transitionda bug olmasin istiyoruz.
    }
    
    
    
    
    func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))  //Burada endEditing fonksiyonunu hangi view'da bu isi yapacagini soylememiz gerekiyor sanirim. Yani hangi view icin editing'i bitireceksin bunu soylemek gerekiyor sanirim. target kisminda da bu searchVc nin bizzat kendi view'i target'imizi oluyor.
        view.addGestureRecognizer(tap)
        
        //NOT; Bu arada keyboard'i dismiss etmenin bircok yolu var. Burada uyguladigmiz bunlardan sadece biri...
    }
    
    
    @objc func pushFollowerListVC(){
        
        guard isUsernameEntered else{
            presenatGFAlertOnMainThread(title: "Empty Username", message: "Please enter username", buttonTitle: "OK")
            print("No Username")
                return
        }
        let followerListVCobject = FollowersListVC()
        followerListVCobject.username = userNameTextField.text
        followerListVCobject.title =  userNameTextField.text //VC nin title'i...
         //Simdi navigationController burada anladigim kadariyla ViewControllerlarin Stackigini tutuyor ve onun uzerine pushlamamiz gerekiyorki followersListVcyi gorebilelim. Mantik Basit usta.
        navigationController?.pushViewController(followerListVCobject, animated: true) //Animated gelirken slide(slayt)  olarak gelmesi olayidir.
        
    }

    
    
    
    func configureLogoImage(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false //That means we're goint to use autoLayout...
        logoImage.image = UIImage(named: "gh-logo")
        
        
        //usually you will use 4 paremetre in constraints height,width,x coordinate, y coordinate...
        //sometimes for the labels you may have 3 constraints...
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 200)
            
            /*
             Bu kısıtlama bloğu, bir `logoImage` adlı `UIImageView` öğesini `view` adlı bir `UIView` üzerine yerleştirirken kullanılan Auto Layout (otomatik yerleşim) kısıtlamalarını tanımlar. Aşağıda her bir kısıtlamanın neyi temsil ettiği detaylı bir açıklama bulunmaktadır:
             
             1. `logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)`: Bu kısıtlama, `logoImage`'in üst kenarını (`topAnchor`), güvenli alan düzenleyicisinin (`safeAreaLayoutGuide`) üst kenarına (`view.safeAreaLayoutGuide.topAnchor`) belirtilen bir boşluk (`constant: 80`) kadar uzakta yerleştirir. Yani, `logoImage`'in üst kenarı, güvenli alan düzenleyicisinin üst kenarından 80 birim daha aşağıda olacak.
             
             2. `logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)`: Bu kısıtlama, `logoImage`'in yatay (X ekseninde) merkezini (`centerXAnchor`), `view`'in yatay merkezine (`view.centerXAnchor`) hizalar. Yani, `logoImage`'in yatay merkezi, `view`'in yatay merkezi ile aynı olacak.
             
             3. `logoImage.widthAnchor.constraint(equalToConstant: 200)`: Bu kısıtlama, `logoImage`'in genişliğini (`widthAnchor`), sabit bir değer olan 200 birim olarak belirler. Yani, `logoImage`'in genişliği sabit olarak 200 birim olacak.
             
             4. `logoImage.heightAnchor.constraint(equalToConstant: 200)`: Bu kısıtlama, `logoImage`'in yüksekliğini (`heightAnchor`), sabit bir değer olan 200 birim olarak belirler. Yani, `logoImage`'in yüksekliği sabit olarak 200 birim olacak.
             
             Bu kısıtlamalar, `logoImage`'in konumunu (`topAnchor`, `centerXAnchor`) ve boyutunu (`widthAnchor`, `heightAnchor`) belirleyerek, `view` içinde düzenli bir şekilde yerleştirilmesini sağlar. Bu örnekte, logo bir öğe olarak `view`'in güvenli alanına belirli bir boşlukla yerleştirilmiş ve `view`'in yatay merkezine hizalanmıştır.
             */
            
        ])
    }
    
    
    func configureUserTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        userNameTextField.delegate = self
        
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
            /*
             Bu kod bloğu, bir `userNameTextField` adlı `UITextField` öğesini `view` adlı bir `UIView` üzerine yerleştirirken kullanılan Auto Layout (otomatik yerleşim) kısıtlamalarını tanımlar. Aşağıda her bir kısıtlamanın neyi temsil ettiği detaylı bir açıklama bulunmaktadır:
             
             1. `userNameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48)`: Bu kısıtlama, `userNameTextField`'in üst kenarını (`topAnchor`) `logoImage`'in alt kenarına (`logoImage.bottomAnchor`) belirtilen bir boşluk (`constant: 48`) kadar uzakta yerleştirir. Yani, `userNameTextField`'in üst kenarı, `logoImage`'in alt kenarından 48 birim daha aşağıda olacak.
             
             2. `userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)`: Bu kısıtlama, `userNameTextField`'in sol kenarını (`leadingAnchor`) `view`'in sol kenarına (`view.leadingAnchor`) belirtilen bir boşluk (`constant: 50`) kadar uzakta yerleştirir. Yani, `userNameTextField`'in sol kenarı, `view`'in sol kenarından 50 birim daha sağda olacak.
             
             3. `userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)`: Bu kısıtlama, `userNameTextField`'in sağ kenarını (`trailingAnchor`) `view`'in sağ kenarına (`view.trailingAnchor`) belirtilen bir boşluk (`constant: -50`) kadar uzakta yerleştirir. Yani, `userNameTextField`'in sağ kenarı, `view`'in sağ kenarından 50 birim daha sola olacak.
             
             4. `userNameTextField.heightAnchor.constraint(equalToConstant: 50)`: Bu kısıtlama, `userNameTextField`'in yüksekliğini (`heightAnchor`), sabit bir değer olan 50 birim olarak belirler. Yani, `userNameTextField`'in yüksekliği sabit olarak 50 birim olacak.
             
             Bu kısıtlamalar, `userNameTextField`'in konumunu (`topAnchor`, `leadingAnchor`, `trailingAnchor`) ve boyutunu (`heightAnchor`) belirleyerek, `view` içinde düzenli bir şekilde yerleştirilmesini sağlar.
             */
        ])
        
    }
    
    
    func configureButton(){
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside) //TouchUp inside dedigimiz normal olarak button'a basmak zaten...
        
        
        NSLayoutConstraint.activate([
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
     }
    

}


