//
//  orientationDelegate.swift
//  table_8-5-2019
//
//  Created by Nathaniel Mcdowell on 8/5/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit

protocol orientationDelegate {
    var myLandscapeFlag:Bool{get}
    func isLandscape() -> Bool
}
