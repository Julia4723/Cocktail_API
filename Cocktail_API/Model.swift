//
//  Model.swift
//  Cocktail_API
//
//  Created by user on 24.02.2025.
//
import UIKit

struct Model: Codable{
    let name: String
    let ingredients: [String]
    let instructions: String
}
