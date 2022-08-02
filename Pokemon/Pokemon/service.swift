//
//  service.swift
//  Pokemon
//
//  Created by Muskan on 01/08/22.
//

import Foundation
import UIKit

class service{
    
    static let share = service()
    let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    func fetchPokemon(completion: @escaping ([Pokemon]) -> ()){

        var pokemonArray = [Pokemon]()
        guard let url = URL(string: url) else{
            fatalError()
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error!)
            }else{
                do{
                    guard let resultArray = try JSONSerialization.jsonObject(with: data!, options: []) as? [AnyObject] else{return}
                   // print(resultArray)
                    for (key , result) in resultArray.enumerated(){
                        if let dictionary = result as? [String: AnyObject]{
                            let pokemon = Pokemon.init(id: key , dictionary: dictionary)
                            guard let imageUrl = pokemon.imageUrl else {return}
                            self.fetchImage(withUrlstring: imageUrl) { (image) in
                                pokemon.image = image
                                pokemonArray.append(pokemon)
                                completion(pokemonArray)
                            }
                            
                            
                           
                            
                        }
                        
                        completion(pokemonArray)
                    }
                    
                }catch{
                    print("Failed to create join with error: ",error.localizedDescription)
                }
                
            }
        }.resume()
                
        
    }
    
    private func fetchImage(withUrlstring urlstring: String, completion: @escaping(UIImage)->()){
        guard let url = URL(string: urlstring) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error)
            }else{
                guard let data = data else {
                    return
                }
                guard let image = UIImage(data: data) else {return}
                
                completion(image)
            }
        }.resume()
        
    }
    
}
