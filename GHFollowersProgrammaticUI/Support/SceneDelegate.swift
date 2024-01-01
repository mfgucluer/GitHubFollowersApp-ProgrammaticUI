//
//  SceneDelegate.swift
//  GHFollowersProgrammaticUI
//
//  Created by Mustafa Fatih on 9/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow? //Buradaki window eskiden appDelegate icindeydi... Simdi sceneDelegate icinde. SceneDelegate tum UI lari configure ediyor boylece
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowSceneX = (scene as? UIWindowScene) else { return }
        
        /*
         Buradakilerin fonksiyonunu yazdigimiz icin bunlari siliyoruz.
         
         
         let searchNC = UINavigationController(rootViewController: SearchVC()) //searh navigation controllerimi olusturuyorum abi. Buna bir root veriyorum tabi ki. Bu sekilde initialize ediyorum.
         let favoriteNC = UINavigationController(rootViewController: FavoritesListVC())
         
         //Daha sonra olusturdugumuz navigationControlleri tabBar controllerini icine koymak istiyoruz. Hocam simdi yaptik calisor ancak tabBar controllerin alt cubuguna ne icon ekledik ne isim.Bunun icin fonksiyonlar olusturacagiz ve bunlari silecegiz.
         */
        
        
     
        
        window = UIWindow(frame: windowSceneX.coordinateSpace.bounds) //ekrani kaplamasi icin
        window?.windowScene = windowSceneX
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = .systemGreen //Bunu asagida fonksiyona yazarakta yapabilirsin ama biz bu sekilde tercih ettik.
    }
    
    
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 0) //Buradaki tag kacinci indexte oldugu usta. Bizim searchVc miz 0. indexte...
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteListController() -> UINavigationController {
        let favoriteListVC = FavoritesListVC()
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)//Bunu yazarken 2 tane favoriteList li sey cikiyor ya karsina orada L olan Local Variable demek... C olan ise yanda olusturdugun class zaten usta.
        
    }
    
    
    func createTabBarController() -> UITabBarController {
        
        
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .black //Burada uiTabBAr diyince tum appteki tabBar i ayarlamis oluyoruz.
        UITabBar.appearance().backgroundColor = .systemGray3
        tabBar.viewControllers = [createSearchNavigationController(),createFavoriteListController()]
        //yazarken aciklamasinda da gordugun gibi viewControllerini arrayini alacaktir.
        //Boylelikle artik abi tabbar holding NC, NC holding viewController...
        return tabBar
        
    }
    
    
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

