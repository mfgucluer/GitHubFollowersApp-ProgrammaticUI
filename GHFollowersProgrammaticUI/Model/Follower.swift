//
//  Follower.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 19/12/23.
//
//

import Foundation

struct Follower: Decodable, Hashable{
    //buradaki olusturdugun struct yapisi senin json yapina birebir uymali. Orada login yaziyorsan Login bile yazamazsin.
    var login: String
    var avatarUrl: String //Burada camel case kullaniyoruz jsonda snake case seklinde ceviriliyormus o kendi kendine. Ama araya baska kelime falan sokamam.
    //Follower adında bir struct tanımlanıyor. Bu struct, GitHub takipçilerini temsil etmek için kullanılıyor. login property'si takipçinin kullanıcı adını, avatarUrl property'si ise takipçinin avatarının URL'sini içerir.
}








