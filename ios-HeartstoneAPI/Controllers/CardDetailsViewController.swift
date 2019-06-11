//
//  CardDetailsViewController.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 10/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var persistentContainer: NSPersistentContainer? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return appDelegate.persistentContainer
    }
    
}

class CardDetailsViewController: UIViewController {

    var cardSelected: Card?
    @IBOutlet weak var cardImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cardSelected = cardSelected else {return}
        if let cardId = cardSelected.cardId, let imageURL = URL(string: "https://art.hearthstonejson.com/v1/render/latest/enUS/256x/\(cardId).png") {
            
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.cardImage.image = image
                }
            }
        }
    }
    
    @IBAction func saveCardToDeck(_ sender: UIButton) {
        guard let context = persistentContainer?.viewContext else {return}
        let card = CardEntity(context: context)
        
        guard let cardSelected = cardSelected else {return}
        card.cardId = cardSelected.cardId
        card.cardSet = cardSelected.cardSet
        card.faction = cardSelected.faction
        card.flavor = cardSelected.flavor
        card.name = cardSelected.name
        card.playerClass = cardSelected.playerClass
        card.rarity = cardSelected.rarity
        card.text = cardSelected.text
        do {
            try context.save()
        } catch {
            print("Failed Saving")
        }
        //leitura
        //card.managedObjectContext?.fetch(CardEntity.fetchRequest())
    }
    
    
}
