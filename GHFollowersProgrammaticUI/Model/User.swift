//
//  User.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 19/12/23.
//

import Foundation


//Aslinda buradaki seyler userInfo screende ihtiyacim olacak seyler
struct User: Codable{
    var login: String
    var avatarUrl: String
    var name: String? // Bunu optional yapiyoruz cunku gelmeyebilirmis bu veri galiba...
    var location: String? //Bu da ayni sekilde adam location koymayabilir
    var bio: String?
    var publicRepos: Int
    var publicGists: Int //Bu iki int li olan bos gelse bile 0 olacagi icin ? yapmaya gerek yok
    var htmlUrl: String //login existse zorunlu olarak htmlUrl de vardir.
    var following: Int
    var followers: Int
    var createdAt: String
    
    
    
    
    
}
