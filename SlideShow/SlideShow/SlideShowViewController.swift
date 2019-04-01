//
//  ViewController.swift
//  SlideShow
//
//  Created by Premkumar  on 29/03/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 16
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SlideShowViewController: UICollectionViewController {
    
    fileprivate var itemCellIdentifier: String = "itemCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        
       // collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.init(white: 0.7, alpha: 1.0)
        cell.contentScaleFactor = 10
        
        return cell
     }

}
