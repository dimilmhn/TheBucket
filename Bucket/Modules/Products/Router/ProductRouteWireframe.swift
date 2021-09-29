//
//  SceneDelegate.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/26.
//

import UIKit

class ProductRouteWireframe {
  class func loadProductComponents(withPresenter presenter: ProductPresenter) {
    presenter.wireframe = ProductRouteWireframe()
    presenter.interactor = ProductInteractor()
    presenter.interactor?.presenter = presenter
  }
}

extension ProductRouteWireframe: ProductWireframeProtocol {}
