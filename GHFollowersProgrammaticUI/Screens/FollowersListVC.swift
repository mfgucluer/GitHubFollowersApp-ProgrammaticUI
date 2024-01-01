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
       
        
        NetworkManager.sharedd.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presenatGFAlertOnMainThread(title: "Bad stuff Happend", message: errorMessage?.rawValue ?? "MFG", buttonTitle: "OK")
                return
            }
            
            print("Followers.count =  \(followers.count)")
            print(followers)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
  
  

}
