//
//  PersistenceManager.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 16/2/24.
//

import Foundation


enum PersistenceActionType {
    case add, remove     //burada actionType'in o an ne oldugunu yonetecegiz.
}
 




//enum'da empty initialize yapamazsin ancak structta yapabilirsin. Bu yuzden struct yerine enum kullandik.


enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard //Bunu surekli kullanacagiz ondan dolayi defaults yaziyoruz.
    
    
    enum Keys {
        static let favorites = "favorites" //bu keyword'u surekli kullanacagimiz icin bu sekilde bir sey yaziyoruz.
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping(GFError?)->Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else{
                        completed(.alreadyInFavorites)
                        return
                        
                    }
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)

            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>)->Void){
        //burada sanki newtwork call yapar gibi completion handeler ve result type kullanacagiz. Yani network call'a cok benzer bir is yapiyoruz.
    
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([])) //eger bir sey yoksa empty array dondurecegiz succes ile.
            return
            //bunu atarken data olarak cast etmemiz gerekiyor ki swifte hey bu bir data diyebilelim.
            //
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        
            
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
        }


    static func save(favorites: [Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch{
            return .unableToFavorite
        }
        
        
    }
    
}

