//
//  ImageView+Extension.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/28.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    enum ImageLoadError: Error {
        case invalidURL
    }
    func setImage(uri: String?, placeholder: UIImage? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        if let uri = uri, let url = URL(string: uri) {
            
            sd_setImage(with: url, placeholderImage: placeholder, options: SDWebImageOptions.retryFailed, completed: { (image, error, _, _) in
                completion?(image, error)
            })
        } else {
            if let validCompletionBlock = completion  {
                validCompletionBlock(nil,ImageLoadError.invalidURL)
            } else {
                image = placeholder
            }
        }
    }
}
