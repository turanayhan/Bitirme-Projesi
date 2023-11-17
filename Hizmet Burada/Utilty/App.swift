//
//  App.swift
//  Hizmet Burada
//
//  Created by turan on 17.11.2023.
//

class App {

    static let shared = App() // Singleton örneği
    
    var container = false
    var containerProfile = true
    
    
    private init() {
       
    }

    func doSomething() {
        
        print("Singleton obje çalıştı.")
    }
}

