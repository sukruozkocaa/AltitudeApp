//
//  CarouselCollectionView.swift
//  AltitudeApp
//
//  Created by Şükrü on 15.09.2023.
//

import Foundation
import UIKit

// Collection View DataSource
@objc public protocol CarouselCollectionViewDataSource {
    
    var numberOfItems: Int { get }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                                cellForItemAt index: Int,
                                fakeIndexPath: IndexPath) -> UICollectionViewCell
    @objc optional func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                                               didSelectItemAt index: Int)
    @objc optional func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                                               didDisplayItemAt index: Int)
}

// Prepare CollectionView
public class CarouselCollectionView: UICollectionView {
    
    public weak var carouselDataSource: CarouselCollectionViewDataSource?

    public let flowLayout: UICollectionViewFlowLayout
    public var autoscrollTimeInterval: TimeInterval = 5.0

    public var isAutoscrollEnabled: Bool = false {
        didSet {
            if isAutoscrollEnabled {
                tryToStartTimer()
            } else {
                stopAutoscrollTimer()
            }
        }
    }

    public var currentPage: Int {
        get {
            
            let center = CGPoint(x: contentOffset.x + (frame.width / 2), y: (frame.height / 2))
            
            if let fakeIndexPath = indexPathForItem(at: center) {
                return getRealIndex(fakeIndexPath)
            } else {
                assertionFailure()
                return 0
            }
        }
        set {
            assert((0..<numberOfItems).contains(newValue))
            setFakePage(newValue + 1)
            notifyDatasourceOnDisplayPage(newValue)
        }
    }

    public var fakeCurrentPage: Int {
        get {
            return Int(ceil(contentOffset.x / flowLayout.itemSize.width))
        }
        set {
            setFakePage(newValue, animated: false)
        }
    }

    private var hasInitializedFirstPage = false
    private var autoscrollTimer: Timer?

    private var numberOfItems: Int {
        return carouselDataSource?.numberOfItems ?? 0
    }

    private var fakeNumberOfItems: Int {
        if let realNumberOfItems = carouselDataSource?.numberOfItems,
            realNumberOfItems > 0 {
            return realNumberOfItems + 2
        } else {
            return 0
        }
    }

    public init(frame: CGRect, collectionViewFlowLayout layout: UICollectionViewFlowLayout) {
        flowLayout = layout
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        isPagingEnabled = true
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        flowLayout = UICollectionViewFlowLayout()
        super.init(coder: aDecoder)
        self.collectionViewLayout = flowLayout
        self.delegate = self
        self.dataSource = self
        isPagingEnabled = true
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }

    private func getRealIndex(_ fakeIndexPath: IndexPath) -> Int {
        guard let realNumberOfItems = carouselDataSource?.numberOfItems else {
            return 0
        }

        if fakeIndexPath.row == realNumberOfItems + 1 {
            return 0
        }

        if fakeIndexPath.row == 0 {
            return realNumberOfItems - 1
        }

        return fakeIndexPath.row - 1
    }

    private func setFakePage(_ fakePage: Int, animated: Bool = false) {
        precondition((0..<fakeNumberOfItems).contains(fakePage))
        let newContentOffset = CGPoint(x: flowLayout.itemSize.width * CGFloat(fakePage), y: 0)
        setContentOffset(newContentOffset, animated: animated)
    }

    public func setCurrentPage(_ page: Int, animated: Bool = false) {
        precondition((0..<numberOfItems).contains(page))
        setFakePage(page + 1, animated: animated)
    }

    private func loopItems(_ scrollView: UIScrollView) {
        let page = fakeCurrentPage
        if (page == 0) {
            setFakePage(fakeNumberOfItems - 2)
        } else if (page == fakeNumberOfItems) {
            setFakePage(1)
        }
    }

    private func notifyDatasourceOnDisplayPage(_ index: Int) {
        carouselDataSource?.carouselCollectionView?(self, didDisplayItemAt: index)
    }

    // MARK: - Autoscrolling

    private func tryToStartTimer() {
        guard isAutoscrollEnabled else {
            return
        }

        autoscrollTimer?.invalidate()
        autoscrollTimer = Timer.scheduledTimer(withTimeInterval: autoscrollTimeInterval, repeats: false) { [weak self] _ in self?.scrollToNextElement() }
    }

    private func stopAutoscrollTimer() {
        autoscrollTimer?.invalidate()
        autoscrollTimer = nil
    }

    private func scrollToNextElement() {
        
        guard self.fakeNumberOfItems > 0 else { return }
        if self.fakeCurrentPage == self.fakeNumberOfItems - 1 {
            self.setFakePage(1)
            let newPageRealIndex = self.fakeCurrentPage < (self.numberOfItems) ? self.fakeCurrentPage : 0
            assert(newPageRealIndex == 1)
            self.setFakePage(self.fakeCurrentPage + 1, animated: true)
            self.tryToStartTimer()
            self.notifyDatasourceOnDisplayPage(newPageRealIndex)
            return
        } else {
            let newPageRealIndex = self.fakeCurrentPage < (self.numberOfItems) ? self.fakeCurrentPage : 0
            self.setFakePage(self.fakeCurrentPage + 1, animated: true)
            self.tryToStartTimer()
            self.notifyDatasourceOnDisplayPage(newPageRealIndex)
        }
    }

}

extension CarouselCollectionView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loopItems(scrollView)
        notifyDatasourceOnDisplayPage(currentPage)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loopItems(scrollView)
        tryToStartTimer()
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        notifyDatasourceOnDisplayPage(currentPage)
    }
}

extension CarouselCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let realIndex = getRealIndex(indexPath)
        carouselDataSource?.carouselCollectionView?(self, didSelectItemAt: realIndex)
    }
}

extension CarouselCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fakeNumberOfItems > 0 && !hasInitializedFirstPage {
            currentPage = 0
            hasInitializedFirstPage = true
        }
        return fakeNumberOfItems
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let carouselDataSource = carouselDataSource else {
            assertionFailure()
            return UICollectionViewCell()
        }

        let index = getRealIndex(indexPath)
        return carouselDataSource.carouselCollectionView(self, cellForItemAt: index, fakeIndexPath: indexPath)
    }
    
}
