//
//  PokemonCollectionViewController.swift
//  Pokemon
//
//  Created by Muskan on 30/07/22.
//

import UIKit

//private let reuseIdentifier = "Cell"


class PokemonCollectionViewController: UICollectionViewController , UISearchResultsUpdating, UISearchBarDelegate{
    
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searchBar = UISearchBar()
    var inSeachMode = false
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.configureViewComponents()
        self.fetchPokemon()

    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        print(text)
    }
    
    private func registerCells(){
        collectionView.register(UINib(nibName: PokiCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PokiCollectionViewCell.reuseIdentifier)
    }
    
    @objc func showSearchBar(){
        print("search")
        configureSeachBar()
    }
    
    
    
    func fetchPokemon(){
        
        service.share.fetchPokemon{ (pokemon) in
            DispatchQueue.main.async {
                
                self.pokemon = pokemon
                self.collectionView.reloadData()
                
            }
        }
        
    }
    
    func configureSeachBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .white
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
    }
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        configureSearchBarButton()
        inSeachMode = false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSeachMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSeachMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
    
    func configureViewComponents(){
        
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Pokemon"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        //searchController.searchResultsUpdater = self
       // navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        
    }

//MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return inSeachMode ? filteredPokemon.count : pokemon.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PokiCollectionViewCell.reuseIdentifier, for: indexPath) as! PokiCollectionViewCell
        cell.pokemon = inSeachMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        cell.layer.cornerRadius = 10
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) {

                let vc = segue.destination as! PokiPopUpViewController //Cast with your DestinationController
                 //Now simply set the title property of vc
                vc.details = pokemon[indexPath.item]
            
       }
    }
        
   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // performSegue(withIdentifier: "segue", sender: self)
        let controller = storyboard?.instantiateViewController(withIdentifier: "segue") as? PokiPopUpViewController
        controller!.details = inSeachMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        navigationController?.pushViewController(controller!, animated: true)
        collectionView.reloadData()
        
        /*
         let controller = storyboard?.
         let controller = storyboard?.instantiateViewController(withIdentifier: "dish") as? DishListViewController
         controller?.category = categories[indexPath.row]
         navigationController?.present(controller!, animated: true, completion: nil)
         
         */
       
        
    }
 
   

   

}

