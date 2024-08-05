//
//  Card.swift
//  Flashzilla
//
//  Created by Ayrton Parkinson on 2024/08/04.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID
    var prompt: String
    var answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
