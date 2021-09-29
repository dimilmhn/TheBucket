//
//  ProductViewController.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/27.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    
    private let presenter: ProductPresenter = ProductPresenter()
    private let refreshControl = UIRefreshControl()

    private var productList = [Product]()
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.blue
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        presenter.viewRef = self
        presenter.viewDidLoad()
    }
    
    // MARK: - View Configurations

    private func configureViewComponents() {
        configureTableView()
        configureActivityIndicator()
        configurePullToRefresh()
    }
    
    private func configureTableView() {
        productTableView.rowHeight = UITableView.automaticDimension
        productTableView.estimatedRowHeight = 266
    }
    
    private func configureActivityIndicator() {
        self.activityIndicator.center = self.productTableView.center
        self.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    private func configurePullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           productTableView.addSubview(refreshControl)
    }
    
    // MARK: - Functionalities
    
    fileprivate func updateWishList(_ product: Product) {
        presenter.updateWishList(item: product)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.global().async {
            self.presenter.refresh()
        }
    }
    
    fileprivate func updateView() {
        self.productTableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
    }
}

extension ProductViewController: ProductPresenterProtocol {
    func updateProductList(items: [Product]?, error: Error?) {
        var message = Constants.Error.Message.generic
        guard error == nil else {
            DispatchQueue.main.async {
                if let networkError = error as? NetworkError {
                    message = networkError.rawValue
                }
                self.showAlert(message)
            }
            return
        }
        
        guard let list = items else {
            DispatchQueue.main.async {
                self.showAlert(Constants.Error.Message.noData)
            }
            return
        }
        
        DispatchQueue.main.async {
            self.productList = list
            self.updateView()
        }
    }
    
    func didUpdateWishList() {
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
}


//MARK: UITableViewDataSource
extension ProductViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return productList.count
  }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellIdentifier, for: indexPath) as? ProductTableViewCell else {  fatalError("Cell not available") }
        let product = productList[indexPath.row]
        cell.populate(product, presenter.hasAddedToWishList(item: product))
        cell.onWishListClicked = { [weak self] product in
            self?.updateWishList(product)
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension ProductViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
