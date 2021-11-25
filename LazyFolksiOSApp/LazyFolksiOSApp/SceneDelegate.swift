//
//  SceneDelegate.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 19/11/21.
//

import UIKit
import Combine
import LazyFolksiOS
import LazyFolksEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let baseURL = URL(string: "https://www.boredapi.com/api/")!
    
    private lazy var httpClient: HTTPClient = {
        let session = URLSession(configuration: .ephemeral)
        return URLSessionHTTPClient(session: session)
    }()
    
    convenience init(httpClient: HTTPClient) {
        self.init()
        self.httpClient = httpClient
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        // Search activity screen will be displayed when app launches
        window?.rootViewController = SearchViewComposer.compose(
            windowBounds: window?.bounds ?? .zero,
            loader: loaderPublisher,
            navigationHandler: displayDetails
        )
        window?.makeKeyAndVisible()
    }
    
    private func displayDetails(for activity: Activity) {
        let activityData = ActivityDetailsViewData(
            title: activity.description,
            type: activity.type,
            participants: "\(activity.participants)",
            price: "\(activity.price)"
        )
        let details = ActivityDetailsComposer.compose(windowBounds: window!.bounds, viewData: activityData)
        window?.rootViewController?.present(details, animated: true)
    }

    private func loaderPublisher(
        type: String,
        participants: String,
        minPrice: String,
        maxPrice: String
    ) -> AnyPublisher<Activity, Error> {
        /*
         The loader will send a request to the URL and then it will
         map the received data
         */
        let url = ActivityEndpoint.get(
            type: type,
            participants: participants,
            minRange: minPrice,
            maxRange: maxPrice
        ).requestURL(baseURL: baseURL)
        return httpClient
            .getPublisher(from: url)
            .dispatchOnMainQueue()
            .tryMap(ActivitiesMapper.map)
            .eraseToAnyPublisher()
    }
}

