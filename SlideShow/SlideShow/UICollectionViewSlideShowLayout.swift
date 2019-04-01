//
//  UICollectionViewSlideShowLayout.swift
//  SlideShow
//
//  Created by Premkumar  on 29/03/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import UIKit

class UICollectionViewSlideShowLayout: UICollectionViewLayout {
    
    fileprivate var numberOfColumn = 1
    fileprivate var cellPadding : CGFloat = 16
    
   fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    var section: Int = 0
    
    fileprivate var contentWidth: CGFloat = 0
    
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let contentInset = collectionView.contentInset
        let height = collectionView.bounds.height - (contentInset.top + contentInset.bottom)
        return height
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        
        let items = collectionView.numberOfItems(inSection: section)
        
        let contentInset = collectionView.contentInset
        contentWidth = collectionView.bounds.width - (contentInset.left + contentInset.right)
        
        var xOffset = [CGFloat]()
        var yOffset = [CGFloat](repeating: 0, count: items)
        
        let columnWidth: CGFloat = contentWidth / CGFloat(numberOfColumn)
        
        for column in 0..<items {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        for item in 0..<items {
            
            let indexPath = IndexPath(item: item, section: section)
            
            let frame = CGRect(x: xOffset[item], y: yOffset[item], width: columnWidth, height: contentHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentWidth = max(contentWidth, frame.maxX)
            let width = contentWidth + 2 * cellPadding
            xOffset[item] = xOffset[item] + width
        }
    }
    
    // MARK: Layout element and item
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }

        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
