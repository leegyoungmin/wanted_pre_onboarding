//
//  ImageCacheService.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation
import UIKit

class ImageCacheManager{
    static let shared = NSCache<NSString,UIImage>()
    private init(){}
}
