//
//  NetworkManager.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 09.02.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func loginWithSerwer(email: String, password: String) {
        print("loginWithSerwer...")
    }
    func getDataFromUrl(url: String) {
        print("getDataFromUrl...")
    }
}
