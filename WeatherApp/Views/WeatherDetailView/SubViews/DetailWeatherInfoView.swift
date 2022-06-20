//
//  File.swift
//  PrettyWeather
//
//  Created by 이경민 on 2022/06/19.
//

import Foundation
import UIKit

class DetailWeatherInfoView:UIView{
    let imageName:String
    let labelValue:String

    // UI component 선언
    lazy var imageView:UIImageView = {
        return UIImageView().symbolImage(self.imageName, .label,30)
    }()
    
    lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = self.labelValue
        return label
    }()
    
    // 초기화
    required init(imageName:String,labelValue:String) {
        self.imageName = imageName
        self.labelValue = labelValue
        super.init(frame: .zero)
        setupLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 세팅
    private func setupLayOut(){
        backgroundColor = .clear
        let stackView = UIStackView(arrangedSubviews: [imageView,descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
