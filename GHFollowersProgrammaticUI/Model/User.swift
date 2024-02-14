//
//  User.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 19/12/23.
//

import Foundation


//Aslinda buradaki seyler userInfo screende ihtiyacim olacak seyler
struct User: Codable{
    let login: String
    let avatarUrl: String
    var name: String? // Bunu optional yapiyoruz cunku gelmeyebilirmis bu veri galiba...
    var location: String? //Bu da ayni sekilde adam location koymayabilir
    var bio: String?
    let publicRepos: Int
    let publicGists: Int //Bu iki int li olan bos gelse bile 0 olacagi icin ? yapmaya gerek yok
    let htmlUrl: String //login existse zorunlu olarak htmlUrl de vardir.
    let following: Int
    let followers: Int
    let createdAt: String
    
    
    
    
     
}
