//
//  WishListRouteWireframe.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import Foundation
class WishListRouteWireframe {
  class func loadProductComponents(withPresenter presenter: WishListPresenter) {
    presenter.wireframe = WishListRouteWireframe()
    presenter.interactor = WishListInteractor()
    presenter.interactor?.presenter = presenter
  }
}

extension ProductRouteWireframe: WishListWireframeProtocol {}
