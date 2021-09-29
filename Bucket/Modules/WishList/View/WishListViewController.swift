//
//  WishListViewController.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var wishListTableView: UITableView!
    var presenter: WishListPresenter = WishListPresenter()
    var wishList = [WishListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewRef = self
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadView()
    }
    
    private func configureTableView() {
        wishListTableView.rowHeight = UITableView.automaticDimension
        wishListTableView.estimatedRowHeight = 266
    }
    
    fileprivate func removeWishList(_ item: WishListItem) {
        presenter.removeWishList(item: item)
    }
}


extension WishListViewController: WishListPresenterProtocol {
    func updateWishList(items: [WishListItem]?, error: Error?) {
        guard error == nil else {
            DispatchQueue.main.async {
                self.showAlert(Constants.Error.Message.generic)
            }
            return
        }
        
        guard let list = items, list.count > 0 else {
            DispatchQueue.main.async {
                self.showAlert(Constants.Error.Message.wishListNoData)
            }
            return
        }
        
        DispatchQueue.main.async {
            self.wishList = list
            self.wishListTableView.reloadData()
        }
    }
    
    func didUpdateDelete() {
        DispatchQueue.main.async {
            self.presenter.loadView()
        }
    }
}


//MARK: UITableViewDataSource
extension WishListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return wishList.count
  }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wishListTableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.cellIdentifier, for: indexPath) as? WishListTableViewCell else {  fatalError("Cell not available") }
        let item = wishList[indexPath.row]
        cell.populate(item)
        cell.onWishListClicked = { [weak self] item in
            self?.removeWishList(item)
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension WishListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
