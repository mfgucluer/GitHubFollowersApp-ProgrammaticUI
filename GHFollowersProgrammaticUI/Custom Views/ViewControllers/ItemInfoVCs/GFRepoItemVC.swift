//
//  GFRepoItemVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 14/2/24.
//

import UIKit


class GFRepoItemVC: GFItemInfoVC{
    
    //Simdi burada tum GFItemInfoVC yi buraha inherit etmis olduk.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems(){
        //GFUserInfoHeaderVC deki init olayini buradan user'a ulasmak icin GFItemInfoVC ye de ekledik. 
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.setInfoButton(backgroundColor: .systemPurple, title: "GitHub Profile")
        
    }
    
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    
    
    
}


