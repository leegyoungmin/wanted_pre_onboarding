//
//  Extensions.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation
import UIKit

//Bundle
extension Bundle{
    func decode<T:Codable>(_ file:String)->T{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("can not find file Name \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("can not convert data \(url)")
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else{
            fatalError("can not decode data to json Decoder")
        }
        return decodedData
    }
}

// Data to Description
func convertCalsiusDescription(_ fahrenheit:Double) -> String{
    let celsius = UnitTemperature.celsius.converter.value(fromBaseUnitValue: fahrenheit)
    return String(format: "%.1f", celsius) + " °C"
}

func convertHpa(_ hpa:Int) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: hpa as NSNumber) ?? ""
}

//MARK: - UIImageView
extension UIImageView{
    func symbolImage(_ imageName:String,_ imageColor:UIColor,_ fontSize:CGFloat)->UIImageView{
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: fontSize, weight: .semibold))
        let image = UIImage(systemName: imageName,withConfiguration: config)?.withTintColor(imageColor,renderingMode: .alwaysOriginal)
        return UIImageView(image: image)
    }
    
    //이미지 캐싱 확인 후 캐싱 값이 없을 경우, urlsession을 통한 데이터 로드
    func setImageUrl(_ iconName:String){
        let urlString = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
        let cachedKey = NSString(string: iconName)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey){
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString){
                URLSession.shared.dataTask(with: url) { data, res, err in
                    if let _ = err{
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data){
                            ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                            self.image = image
                        }
                    }
                }
                .resume()
            }
        }
    }
}

//UIStackView
extension UIStackView{
    func myStackView(_ views:[UIView])->UIStackView{
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        return stackView
    }
}

//UILabel
extension UILabel{
    func myLabel(_ textColor:UIColor,_ font:UIFont)->UILabel{
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        return label
    }
}
