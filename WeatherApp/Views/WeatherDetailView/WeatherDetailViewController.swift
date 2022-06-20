//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation
import UIKit

class WeatherDetailViewController:UIViewController{
    let service:WeatherApiService = WeatherApiService.shared
    let geoList:[geometry] = Bundle.main.decode("geometryId.json")
    var selectedIndex = 0
    var controllers:[UIViewController] = []
    
    lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.delegate = self
        pageController.dataSource = self
        pageController.view.backgroundColor = UIColor(named: "BackgroundColor")
        return pageController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        makeControllerList()
        config()
    }
    
    func config(){
        pageController.setViewControllers([controllers[selectedIndex]], direction: .forward, animated: true)
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pageController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        pageController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        pageController.didMove(toParent: self)
    }
    
    func makeControllerList(){
        for index in service.weatherList.indices{
            let controller = WeatherDetailChilViewController(weather: service.weatherList[index], geometry: geoList[index])
            self.controllers.append(controller)
        }
    }
    
    func setUpNavigationBar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "날씨 상세 정보"
    }
}

extension WeatherDetailViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else{return nil}
        let prevIndex = index - 1
        guard prevIndex >= 0 else {
            return nil
        }
        guard controllers.count > prevIndex else { return nil }
        return controllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else{return nil}
        let nextIndex = index + 1
        guard nextIndex < controllers.count else {
            return nil
        }
        guard controllers.count > nextIndex else{ return nil }
        return controllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return selectedIndex
    }
}
