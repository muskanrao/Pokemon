//
//  PokiCollectionViewCell.swift
//  Pokemon
//
//  Created by Muskan on 31/07/22.
//

import UIKit

class PokiCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier  = String(describing: PokiCollectionViewCell.self)

    @IBOutlet weak var pokiImage: UIImageView!  
    @IBOutlet weak var pokiName: UILabel!
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureViewComponents(){
        
        
       // addSubview(pokiImage)
        //addSubview(pokiName)
       // addSubview(stack)
    }
    var pokemon: Pokemon?{
        didSet{
            print(pokemon?.imageUrl)
            pokiImage.image = pokemon?.image
            pokiName.text = pokemon?.name
        }
    }
    
    /*
     
    func setup(details: setDetails){
       // view.backgroundColor = .lightGray
        pokiImage.image = .init(named: details.image)
        pokiName.text = details.name
    }*/
    

}
/*
struct setDetails{
    let name: String
    let image: String
}*/
