//
//  DeckViewController.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 10/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit
import CoreData


class DeckViewController: UIViewController {

    @IBOutlet weak var favoriteCardCollectionView: UICollectionView!
    var favoriteCards: [CardEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        favoriteCardCollectionView.delegate = self
        favoriteCardCollectionView.dataSource = self

        guard let context = persistentContainer?.viewContext else {return}
        
        DispatchQueue.main.async {
            guard let cards = try? context.fetch(CardEntity.fetchRequest()) else {return}
            self.favoriteCards = cards as! [CardEntity]
            self.favoriteCardCollectionView.reloadData()
        }
            
       
    }
}

extension DeckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cards = self.favoriteCards else {return 0}
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cards = self.favoriteCards else {return UICollectionViewCell()}
        let cell = favoriteCardCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        if let cardId = cards[indexPath.row].cardId, let imageURL = URL(string: "https://art.hearthstonejson.com/v1/render/latest/enUS/256x/\(cardId).png") {

            
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.cardImageView.image = image
                }
            }
        }
        
        return cell
    }
}
