//
//  UIButton-Category.swift
//  RubbishProject
//
//  Created by ZCC on 2020/5/5.
//  Copyright © 2020 rubbish. All rights reserved.
//

import UIKit

extension Bundle {
    
    /// 命名空间
    var nameSpace: String {
        return self.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
