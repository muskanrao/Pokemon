//
//  PokiPopUpViewController.swift
//  Pokemon
//
//  Created by Muskan on 02/08/22.
//

import UIKit

class PokiPopUpViewController: UIViewController {

    @IBOutlet weak var pokiName: UILabel!
    @IBOutlet weak var pokiImage: UIImageView!
    @IBOutlet weak var pokiType: UILabel!
    @IBOutlet weak var pokiId: UILabel!
    @IBOutlet weak var pokiHeight: UILabel!
    @IBOutlet weak var pokiWeight: UILabel!
    @IBOutlet weak var pokiDescription: UILabel!
    @IBOutlet weak var pokiStrength: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pokiDeffence: UILabel!
    
   var details: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.reloadInputViews()
        view.addSubview(pokiName)
        view.addSubview(pokiImage)
        view.addSubview(pokiType)
        view.addSubview(pokiId)
        view.addSubview(pokiHeight)
        view.addSubview(pokiWeight)
        view.addSubview(pokiDescription)
        view.addSubview(pokiStrength)
        view.addSubview(pokiDeffence)
        view.addSubview(button)
        
        pokiName.text = details?.name?.capitalized
        navigationItem.title = details.name?.capitalized
        print(pokiName.text)
        let id = details.id ?? 0
        let type = details.type ?? ""
        let height = details.height ?? 0
        let weight = details.weight ?? 0
        let attacks = details.attack ?? 0
        let deffence = details.defense ?? 0
        pokiId.text = " \(id)"
        pokiImage.image = details?.image
        pokiType.text = "\(type)"
        pokiHeight.text = "\(height)"
        pokiWeight.text = "\(weight)"
        pokiDescription.text = details?.description
        pokiStrength.text = "\(attacks)"
        pokiDeffence.text = "\(deffence)"
        
        
        
        
        
    }
    
   /*
    var details: Pokemon!{
        didSet{
            print(details?.name?.capitalized)
            if  details!.name != nil{
                print("Name for pokemon selected: \(details?.name)")
                pokiName?.text = details?.name
            }else{
                pokiName.text = details?.name?.capitalized
                 
                 pokiType.text = details?.type
                 pokiId.text = ("Pokimon Id: \(details?.id)")
                 pokiHeight.text = ("Pokimon Height: \(details?.height)")
                 pokiWeight.text = ("Pokimon Weight: \(details?.weight)")
                 pokiDescription.text = details?.description
                 pokiStrength.text = details?.baseExperience
                 pokiImage.image = details?.image
            }
           
            
        }
    }*/
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    

   

}
