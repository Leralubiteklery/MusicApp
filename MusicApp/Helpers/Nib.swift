//
//  Nib.swift
//  MusicApp
//
//  Created by Lera Savchenko on 8.08.24.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil)![0] as! T
    }
    
}
