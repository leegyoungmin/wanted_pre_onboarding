//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation
import UIKit

class MainWeatherViewController:UIViewController{
    let service:WeatherApiService = WeatherApiService.shared
    let geoList:[geometry] = Bundle.main.decode("geometryId.json")
    var weatherDatas:[WeatherModel] = []
    
    lazy var collectionView:UICollectionView = {
        
        let viewLayer = UICollectionViewFlowLayout()
        viewLayer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        viewLayer.minimumLineSpacing = 20
        viewLayer.minimumInteritemSpacing = 1
        
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayer)
        myCollectionView.backgroundColor = .clear
        
        myCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        
        return myCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setUpNavBar()

        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        fetchData()
    }
    
    func fetchData(){
        geoList.forEach { geoid in
            service.load(geoid.id) { _ in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            }
        }
    }
    
    func setUpNavBar(){
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        self.navigationItem.title = "오늘의 날씨"
    }
    

}
extension MainWeatherViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 30
        
        let size = CGSize(width: width, height: 130)
        return size
    }
}
extension MainWeatherViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        service.weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CustomCell", for: indexPath) as! WeatherCollectionViewCell
        let geoName = self.geoList[indexPath.row].korName
        let data = self.service.weatherList[indexPath.row]
        
        cell.geoLabel.text = geoName.contains("시")||geoName.contains("도") ? geoName:geoName + "시"
        cell.tempLabel.text = convertCalsiusDescription(data.main.temp)
        cell.humidityLabel.text = data.main.humidity.description + "%"
        cell.weatherImageView.setImageUrl(data.weathers.first!.icon)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveDetailView(index: indexPath.row)
    }
    
    @objc func moveDetailView(index:Int){
        let controller = WeatherDetailViewController()
        controller.selectedIndex = index
        self.present(controller, animated: true)
    }
}
