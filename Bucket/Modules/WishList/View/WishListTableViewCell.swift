//
//  WishListTableViewCell.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    static let cellIdentifier = "WishListTableViewCellIdentifier"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    
    var onWishListClicked: ((WishListItem) -> Void)?
    var item: WishListItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populate(_ item: WishListItem) {
        self.item = item
        self.titleLabel.text = item.name
        self.detailsLabel.text = item.details
        self.priceLabel.text = item.price
        self.pictureImageView.setImage(uri: item.url, placeholder: UIImage(named: Constants.Placeholder.product)) { (image, error) in
            self.pictureImageView?.image = image ?? UIImage(named: Constants.Placeholder.product)
        }
        setWishListTitle()
    }
    
    private func setWishListTitle() {
        wishListButton.setTitle(Constants.WishList.remove, for: .normal)
    }
    
    func setCornerRadious() {
        self.wishListButton.layer.cornerRadius = 5
        self.pictureImageView.layer.cornerRadius = 5
    }
    
    @IBAction func wishListButtonClicked(_ sender: Any) {
        onWishListClicked?(item)
    }
}
