//
//  GFFollowerItemVC.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 14/2/24.
//

import Foundation




class GFFollowerItemVC: GFItemInfoVC{
    
    //Simdi burada tum GFItemInfoVC yi buraha inherit etmis olduk.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems(){
        //GFUserInfoHeaderVC deki init olayini buradan user'a ulasmak icin GFItemInfoVC ye de ekledik.
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.setInfoButton(backgroundColor: .systemGreen, title: "Get Followers")
        
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
}
