//
//  Pokemon.swift
//  Pokedex
//
//  Created by Aaron Li on 5/10/20.
//  Copyright © 2020 Aaron Li. All rights reserved.
//

import UIKit

struct EvolutionChain
{
    var evolutionArray: [[String: AnyObject]]?
    var evolutionIds = [Int]()
    
    init(evolutionArray: [[String: AnyObject]])
    {
        self.evolutionArray = evolutionArray
        self.evolutionIds = setEvolutionIds()
    }
    
    func setEvolutionIds() -> [Int]
    {
        var results = [Int]()
        
        evolutionArray?.forEach({ (dictionary) in
            if let idString = dictionary["id"] as? String
            {
                guard let id = Int(idString) else {return}
                
                if id <= 151
                {
                    results.append(id)
                }
                
            }
        })
        return results
    }
}

class Pokemon
{
    //contacts API for data displaying values of Type, Defense, Stat, etc
    
    var name: String?
    var imageUrl: String?
    var image: UIImage?
    var id: Int?
    var weight: Double?
    var height: Double?
    var defense: Int?
    var attack: Int?
    var description: String?
    var type: String?
    var evolutionChain: [[String: AnyObject]]?
    var evoArray: [Pokemon]?
    var weak: String
    
    
    init(id: Int, dictionary: [String: AnyObject])
    {
        self.id = id
        
        //checks if data exists in dictionary (if bulbasaur exists or not and return it)
        if let name = dictionary["name"] as? String
        {
            self.name = name
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String
        {
            self.imageUrl = imageUrl
        }
        
        if let weight = dictionary["weight"] as? Int
        {
            self.weight = Double(weight) * 0.10
            
            //floor(Double(weight) * 0.10)
            
        }
        
        if let height = dictionary["height"] as? Int
        {
            self.height = Double(height) * 0.10
            //print(self.height)
        }
        
        if let defense = dictionary["defense"] as? Int
        {
            self.defense = defense
        }
        
        if let attack = dictionary["attack"] as? Int
        {
            self.attack = attack
        }
        
        if let description = dictionary["description"] as? String
        {
            self.description = description
        }
        
        if let type = dictionary["type"] as? String
        {
            self.type = type.capitalized
        }
        
        if let evolutionChain = dictionary["evolutionChain"] as? [[String: AnyObject]] {
                   self.evolutionChain = evolutionChain
               }
               
               
               if self.type == "Fire"
               {
                   self.weak = "Ground, Rock, Water"
               }
               else if self.type == "Water"
               {
                   self.weak = "Electric, Grass"
               }
               else if self.type == "Grass"
               {
                   self.weak = "Fire, Flying, Ice, Poison, Bug"
               }
               else if self.type == "Bug"
               {
                   self.weak = "Fire, Flying, Rock"
               }
               else if self.type == "Dark"
               {
                   self.weak = "Bug, Fariy, Fighting"
               }
               else if self.type == "Dragon"
               {
                   self.weak = "Dragon, Fairy, Ice"
               }
               else if self.type == "Electric"
               {
                   self.weak = "Ground"
               }
               else if self.type == "Fairy"
               {
                   self.weak = "Poison, Steel"
               }
               else if self.type == "Fighting"
               {
                   self.weak = "Fairy, Flying, Phychic"
               }
               else if self.type == "Flying"
               {
                   self.weak = "Electric, Ice, Rock"
               }
               else if self.type == "Ghost"
               {
                   self.weak = "Dark, Ghost"
               }
               else if self.type == "Ground"
               {
                   self.weak = "Grass, Ice, Water"
               }
               else if self.type == "Ice"
               {
                   self.weak = "Fighting, Fire, Rock, Steel"
               }
               else if self.type == "Normal"
               {
                   self.weak = "Fighting"
               }
               else if self.type == "Poison"
               {
                   self.weak = "Ground, Psychic"
               }
               else if self.type == "Rock"
               {
                   self.weak = "Fighting, Grass, Ground, Water"
               }
               else
               {
                   self.weak = "Fighting , Fire, Ground"
               }
           
    }
   
}


extension Double {
       func round(to places: Int) -> Double {
           let divisor = pow(10.0, Double(places))
           return (self * divisor).rounded() / divisor
       }
   }
