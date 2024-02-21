//
//  ErrorMessage.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 31/12/23.
//

import Foundation



enum GFError: String, Error {
    
    case invalidUsername = "This username created an invaled request. Please try again."
    case unabletoComplete = "Unable to complete your request. Please check your"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must really like them!"
    
}




