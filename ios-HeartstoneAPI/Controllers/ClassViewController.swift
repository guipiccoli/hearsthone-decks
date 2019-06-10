//
//  ClassViewController.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 07/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {
    
    let classes = ["mage-portrait","rogue-portrait","warrior-portrait","hunter-portrait","warlock-portrait","priest-portrait","paladin-portrait"]
    let nameClasses = ["Mage","Rogue","Warrior","Hunter","Warlock","Priest","Paladin"]
    var currentSelected: Int?
    
    @IBOutlet weak var classCollectionView: UICollectionView!
    @IBOutlet weak var classNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classCollectionView.dataSource = self
        classCollectionView.delegate = self
        
    }
    @IBAction func classSelectionButton(_ sender: UIButton) {
        if currentSelected == nil {
            currentSelected = 0
        }
        performSegue(withIdentifier: "deckList", sender: nameClasses[currentSelected!])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deckList = segue.destination as? CardsViewController {
            if let classSelected = sender as? String {
                deckList.classSelected = classSelected
            }
        }
        
    }
}

extension ClassViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = classCollectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath) as! ClassCollectionViewCell
        
        cell.portraitImageView.image = UIImage(named: classes[indexPath.item])
        return cell
    }    
}

extension ClassViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else {return}
//        let point = CGPoint(x: collectionView.center.x + collectionView.contentOffset.x, y: collectionView.center.y + collectionView.contentOffset.y)
//        let index = collectionView.indexPathForItem(at: point)
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) else {return}
        
        classNameLabel.text = nameClasses[visibleIndexPath.row]
        classNameLabel.sizeToFit()

        currentSelected = visibleIndexPath.row

    }
    
}
