//
//  GFItemInfoVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 13/2/24.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
     
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        // Do any additional setup after loading the view.
    }
        
    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
        
    }
    
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
        
    }
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
                
                NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
                    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                    stackView.heightAnchor.constraint(equalToConstant: 50),
                    
                    actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
                    actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                    actionButton.heightAnchor.constraint(equalToConstant: 44)
                ])
    }
    
    
    
}
