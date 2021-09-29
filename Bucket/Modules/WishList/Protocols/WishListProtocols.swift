//
//  WishListProtocols.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import Foundation
import UIKit

protocol WishListViewProtocol {
    var viewRef: WishListViewController? {get set}
    var wireframe: WishListRouteWireframe? {get set}
    var interactor: WishListInteractor? {get set}
    //View -> Presenter
    func loadView()
    func removeWishList(item: WishListItem)
}

protocol WishListPresenterProtocol {
  //Presenter -> View
    func updateWishList(items: [WishListItem]?, error: Error?)
    func didUpdateDelete()
}

protocol WishListInteractorInputProtocol {
    var presenter: WishListPresenter? {get set}
    func fetachWishList()
    func removeFromWishList(_ item: WishListItem)
}

protocol WishListInteractorOutputProtocol {
    //Interactor -> Protocol
    func didFinishFetch(items: [WishListItem]?, error: Error?)
    func didWishListDelete()
}

protocol WishListWireframeProtocol {
  //Presenter -> Wireframe
}
