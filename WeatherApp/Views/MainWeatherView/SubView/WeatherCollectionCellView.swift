//
//  WeatherCollectionViewCell.swift
//  PrettyWeather
//
//  Created by 이경민 on 2022/06/17.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    lazy var geoLabel:UILabel = {
        return UILabel().myLabel(.white, .systemFont(ofSize: 25, weight: .bold))
    }()
    
    lazy var tempLabel:UILabel = {
        return UILabel().myLabel(.white, .systemFont(ofSize: 30, weight: .bold))
    }()
    
    lazy var humidityLabel:UILabel = {
        return UILabel().myLabel(.lightGray, .systemFont(ofSize: 15, weight: .light))
    }()
    
    lazy var weatherImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var rainImage:UIImageView = {
        return UIImageView().symbolImage("drop.fill", .blue.withAlphaComponent(0.3), 20)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        [geoLabel,tempLabel,humidityLabel,weatherImageView,rainImage].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        contentView.addSubview(geoLabel)
        contentView.backgroundColor = .systemFill
        contentView.layer.cornerRadius = 10

        geoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        geoLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        geoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: geoLabel.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor).isActive = true
        
        rainImage.leadingAnchor.constraint(equalTo: geoLabel.leadingAnchor).isActive = true
        rainImage.topAnchor.constraint(equalTo: geoLabel.bottomAnchor).isActive = true
        
        humidityLabel.leadingAnchor.constraint(equalTo: rainImage.trailingAnchor,constant: 10).isActive = true
        humidityLabel.centerYAnchor.constraint(equalTo: rainImage.centerYAnchor).isActive = true

    }
}
