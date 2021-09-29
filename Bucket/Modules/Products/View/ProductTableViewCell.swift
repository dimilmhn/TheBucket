//
//  ProductTableViewCell.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/27.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ProductTableViewCellIdentifier"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    
    var onWishListClicked: ((Product) -> Void)?
    var productItem: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populate(_ item: Product, _ hasAddedToWishList: Bool) {
        productItem = item
        titleLabel.text = item.name
        detailsLabel.text = item.details
        priceLabel.text = item.price
        self.pictureImageView.setImage(uri: item.url, placeholder: UIImage(named: Constants.Placeholder.product)) { (image, error) in
            self.pictureImageView?.image = image ?? UIImage(named: Constants.Placeholder.product)
        }
        setWishList(status: hasAddedToWishList)
    }
    
    private func setWishList(status: Bool) {
        status ? wishListButton.setTitle(Constants.WishList.remove, for: .normal) : wishListButton.setTitle(Constants.WishList.add, for: .normal)
    }
    
    func setCornerRadious() {
        self.wishListButton.layer.cornerRadius = 5
        self.pictureImageView.layer.cornerRadius = 5
    }
    
    @IBAction func wishListButtonClicked(_ sender: Any) {
        onWishListClicked?(productItem)
    }
}
