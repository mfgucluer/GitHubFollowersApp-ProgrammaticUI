//
//  UserInfoVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 12/2/24.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}





class UserInfoVC: UIViewController {
    
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    var itemViews: [UIView] = []
    var textDateLabel = GFBodyLabel(textAligment: .center)
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo(){
        
        NetworkManager.sharedd.getUserInfo(for: username) { [weak self] result in
                    
            guard let self = self else { return }
                    
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async{self.configureUIElements(with: user)}
                
            case .failure(let error):
                self.presenatGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureUIElements(with user: User){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemView1)
        self.add(childVC: followerItemVC, to: self.itemView2)
        self.textDateLabel.text = "GitHub since \(user.createdAt.prefix(4))" //Sean allen abim bunu extension kisminda date formatter falan yapiyor sirf june january gibi ayi da gostermek icin. Gerek gormedim ben ugrastiriyor. Bu sekilde bir seye ihtiyacin olursa bakarsin.
        
        
    }
    
    
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView,itemView1,itemView2,textDateLabel]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
                ])
        }
   
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
             
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            textDateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            textDateLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presenatGFAlertOnMainThread(title: "Invalid URL!", message: "Cannot acces the GitHub Profile.", buttonTitle:   "OK!")
            return
        }
        /*
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)

         viewcontroller extensiona goturduk bunu....
         */
        
        PresentsafariView(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {presenatGFAlertOnMainThread(title: "No Followers", message: "This user has no followers.What a shame", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
   
    
}
