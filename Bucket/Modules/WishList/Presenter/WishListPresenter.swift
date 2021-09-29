//
//  WishListPresenter.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import Foundation

class WishListPresenter: WishListViewProtocol {
    var wireframe: WishListRouteWireframe?
    var viewRef: WishListViewController?
    var interactor: WishListInteractor?
    
    func loadView() {
        WishListRouteWireframe.loadProductComponents(withPresenter: self)
        interactor?.fetachWishList()
    }
    
    func removeWishList(item: WishListItem) {
        interactor?.removeFromWishList(item)
    }
}

extension WishListPresenter: WishListInteractorOutputProtocol {
    func didFinishFetch(items: [WishListItem]?, error: Error?) {
        viewRef?.updateWishList(items: items, error: error)
    }
    
    func didWishListDelete() {
        viewRef?.didUpdateDelete()
    }
}
