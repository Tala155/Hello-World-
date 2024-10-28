//
//  RecipeModel.swift
//  Hello World!
//  Created by Tala Abdullah on 28/10/2024.
//
import Foundation
import PhotosUI

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var measurement: String
    var serving: Int
}

struct Recipe: Identifiable {
    let id: UUID = .init()
    let name: String
    var image: UIImage?
    let description: String
    var ingredients: [Ingredient]  // Array to store ingredients
}


    
