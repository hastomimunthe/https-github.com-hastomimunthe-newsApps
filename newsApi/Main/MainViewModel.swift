//
//  MainViewModel.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import Foundation

class MainViewModel {
    
   private let categories = ["Business", "Entertainment", "General", "Health", "Science", "Sport", "Technology"]
    
    func loadCategories(didLoadCategories: @escaping (([String]) -> Void)) {
        didLoadCategories(categories)
    }
}
