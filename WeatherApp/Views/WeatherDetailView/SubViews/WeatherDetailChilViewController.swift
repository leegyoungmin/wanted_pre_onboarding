//
//  WeatherDetailItemViewController.swift
//  PrettyWeather
//
//  Created by 이경민 on 2022/06/20.
//
import UIKit
class WeatherDetailChilViewController:UIViewController{
    let weather:WeatherModel
    let geometry:geometry
    
    //MARK: - INIT
    init(weather:WeatherModel,geometry:geometry){
        self.weather = weather
        self.geometry = geometry
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI COMPONENT 선언
    lazy var weatherIconView:UIImageView = {
        let iconView = UIImageView()
        iconView.sizeToFit()
        return iconView
    }()
    
    lazy var titleLabel:UILabel = {
        return UILabel().myLabel(.white, UIFont.systemFont(ofSize: 35, weight: .heavy))
    }()
    
    lazy var tempLabel:UILabel = {
        return UILabel().myLabel(.white, UIFont.systemFont(ofSize: 35, weight: .bold))
    }()
    
    lazy var weatherDescriptionLabel:UILabel = {
        return UILabel().myLabel(.white, UIFont.systemFont(ofSize: 25, weight: .bold))
    }()
    
    lazy var feelLabel:UILabel = {
        return UILabel().myLabel(.lightGray, UIFont.systemFont(ofSize: 15, weight: .regular))
    }()
    
    lazy var upIcon:UIImageView = {
        return UIImageView().symbolImage("arrow.up", .white,20)
    }()
    
    lazy var downIcon:UIImageView = {
        return UIImageView().symbolImage("arrow.down", .white,20)

    }()
    
    lazy var upLabel:UILabel = {
        return UILabel().myLabel(.white, UIFont.systemFont(ofSize: 15, weight: .regular))
    }()
    lazy var downLabel:UILabel = {
        return UILabel().myLabel(.white, UIFont.systemFont(ofSize: 15, weight: .regular))
    }()
    
    lazy var pressureStackView:DetailWeatherInfoView = {
        return DetailWeatherInfoView(imageName: "gauge", labelValue: convertHpa(weather.main.pressure).description + "hpa")
    }()
    
    lazy var humedityStackView:DetailWeatherInfoView = {
        return DetailWeatherInfoView(imageName: "drop", labelValue: self.weather.main.humidity.description + "%")
    }()
    
    lazy var windStackView:DetailWeatherInfoView = {
        return DetailWeatherInfoView(imageName: "wind", labelValue: self.weather.wind.speed.description + "km/s")
    }()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitleSetting()
        setUpLayout()
        setUpData()
    }
    
    // 레이아웃 설정
    private func setUpLayout(){
        view.backgroundColor = .clear
        let subViewStackView = UIStackView(arrangedSubviews: [pressureStackView,humedityStackView,windStackView])
        subViewStackView.axis = .horizontal
        subViewStackView.distribution = .fillEqually
        subViewStackView.alignment = .center
        subViewStackView.layer.cornerRadius = 15
        subViewStackView.backgroundColor = .systemFill

        [weatherIconView,titleLabel,tempLabel,weatherDescriptionLabel,feelLabel,upIcon,upLabel,downIcon,downLabel,subViewStackView].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.centerXAnchor.constraint(equalTo: weatherIconView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 50).isActive = true
        
        weatherIconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        weatherIconView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 30).isActive = true
        weatherIconView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        weatherIconView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        tempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tempLabel.topAnchor.constraint(equalTo: weatherIconView.bottomAnchor,constant: 30).isActive = true
        
        weatherDescriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        weatherDescriptionLabel.topAnchor.constraint(equalTo: self.tempLabel.bottomAnchor,constant: 5).isActive = true
        
        feelLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        feelLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor,constant: 15).isActive = true
        
        upIcon.trailingAnchor.constraint(equalTo: self.view.centerXAnchor,constant: -50).isActive = true
        upIcon.topAnchor.constraint(equalTo: self.feelLabel.bottomAnchor,constant: 80).isActive = true
        
        upLabel.centerXAnchor.constraint(equalTo: upIcon.centerXAnchor).isActive = true
        upLabel.topAnchor.constraint(equalTo: upIcon.bottomAnchor,constant: 10).isActive = true
        
        
        downIcon.leadingAnchor.constraint(equalTo:self.view.centerXAnchor,constant: 50).isActive = true
        downIcon.topAnchor.constraint(equalTo: self.feelLabel.bottomAnchor,constant: 80).isActive = true
        
        downLabel.centerXAnchor.constraint(equalTo: downIcon.centerXAnchor).isActive = true
        downLabel.topAnchor.constraint(equalTo: downIcon.bottomAnchor,constant: 10).isActive = true
        
        
        subViewStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subViewStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -50).isActive = true
        subViewStackView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        subViewStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    //네비게이션 바 설정
    private func navigationTitleSetting(){
        self.parent?.navigationItem.title = geometry.korName
    }
    
    private func setUpData(){
        titleLabel.text = self.geometry.korName.contains("시")||self.geometry.korName.contains("도") ? self.geometry.korName:self.geometry.korName+"시"
        tempLabel.text = convertCalsiusDescription(weather.main.temp)
        weatherIconView.setImageUrl(weather.weathers.first!.icon)
        feelLabel.text = "체감 \(convertCalsiusDescription(weather.main.feels))"
        weatherDescriptionLabel.text = weather.weathers.first!.weatherDescription
        upLabel.text = convertCalsiusDescription(weather.main.maxTemp).description
        downLabel.text = convertCalsiusDescription(weather.main.minTemp).description

    }
    
}
