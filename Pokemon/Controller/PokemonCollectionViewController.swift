//
//  PokemonCollectionViewController.swift
//  Pokemon
//
//  Created by Muskan on 30/07/22.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PokemonCollectionViewController: UICollectionViewController {
    
    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.configureViewComponents()
        self.fetchPokemon()

    }
    
    private func registerCells(){
        collectionView.register(UINib(nibName: PokiCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PokiCollectionViewCell.reuseIdentifier)
    }
    
    @objc func showSearchBar(){
        
        print("1234")
        
    }
    
    func fetchPokemon(){
        
        service.share.fetchPokemon{ (pokemon) in
            DispatchQueue.main.async {
                
                self.pokemon = pokemon
                self.collectionView.reloadData()
                
            }
        }
        
    }
    
    func configureViewComponents(){
        
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Pokemon"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        
    }



//MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pokemon.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PokiCollectionViewCell.reuseIdentifier, for: indexPath) as! PokiCollectionViewCell
        cell.pokemon = pokemon[indexPath.item]
        cell.layer.cornerRadius = 10
        // cell.backgroundColor = .lightGray
        // cell.pokiName.backgroundColor = .systemPink
        // cell.setup(details: pokiStack[indexPath.row])
        
        //  cell.backgroundColor = .lightGray
        //  cell.stack.backgroundColor = .systemPink
        // Configure the cell
    
        return cell
    }
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
         let width = (view.frame.width - 36)/3
         return CGSize(width: width, height: width)
         
     }
     */
   

   

}
