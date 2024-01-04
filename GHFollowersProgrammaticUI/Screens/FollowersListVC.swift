//
//  FollowersListVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 16/12/23.
//



import UIKit

class FollowersListVC: UIViewController {
    
    
    var username: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // Buyuk olmasini istiyoruz.
        
        
        
        NetworkManager.sharedd.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case.success(let followers):
                print(followers)
                
            case.failure(let error):
                self.presenatGFAlertOnMainThread(title: "Bad stuff Happend", message: error.rawValue ?? "MFG", buttonTitle: "OK")
                
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
  
}
