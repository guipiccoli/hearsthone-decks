//
//  ViewController.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 06/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cards : [Card]?
    var classSelected: String?
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        
        if classSelected != nil {
            DataRequest.getCards(classCards: classSelected!) { (cards) in
                self.cards = cards
                
                DispatchQueue.main.async {
                    self.cardsCollectionView.reloadData()
                }
            }
        }
    }
    

}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cards = self.cards else {return 0}
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cards = self.cards else {return UICollectionViewCell()}
        let cell = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
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

extension CardsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cards = cards else {return}
        guard let card: Card = cards[indexPath.row] else {return}
        performSegue(withIdentifier: "cardDetails", sender: card)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cardDetails = segue.destination as? CardDetailsViewController {
            if let cardSelected = sender as? Card {
                cardDetails.cardSelected = cardSelected
            }
        }
    }
}
