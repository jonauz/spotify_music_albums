//
//  AppDelegate.swift
//  MusicAlbums
//
//  Created by Jonas Simkus on 09/07/2020.
//  Copyright © 2020 Jonas Simkus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.rootViewController = UINavigationController(rootViewController: AlbumsViewController())
        window = newWindow
        newWindow.makeKeyAndVisible()
        return true
    }

}

