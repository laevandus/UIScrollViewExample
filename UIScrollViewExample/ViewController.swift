//
//  ViewController.swift
//  UIScrollViewExample
//
//  Created by Toomas Vahter on 05.10.2019.
//  Copyright © 2019 Augmented Code. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBAction func openVerticallyScrollableView(_ sender: Any) {
        let detailViewController = DetailViewController(scrollingDirection: .vertically)
        navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func openHorizontallyScrollableView(_ sender: Any) {
        let detailViewController = DetailViewController(scrollingDirection: .horizontally)
        navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func openVerticallyAndHorizontallyScrollableView(_ sender: Any) {
        let detailViewController = DetailViewController(scrollingDirection: .verticallyAndHorizontally)
        navigationController!.pushViewController(detailViewController, animated: true)
    }
}

final class DetailViewController: UIViewController {
    enum ScrollingDirection {
        case vertically, horizontally, verticallyAndHorizontally
    }
    
    let scrollingDirection: ScrollingDirection
    
    init(scrollingDirection: ScrollingDirection) {
        self.scrollingDirection = scrollingDirection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView(frame: .zero)
        
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView(frame: .zero)
            scrollView.backgroundColor = .white
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let customView = CustomView(frame: .zero)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        switch scrollingDirection {
        case .vertically:
            scrollView.addSubview(customView)
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                customView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                customView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                customView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        case .horizontally:
            scrollView.addSubview(customView)
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                customView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                customView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                customView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor)
            ])
        case .verticallyAndHorizontally:
            scrollView.addSubview(customView)
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                customView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                customView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
            ])
        }
    }
}

final class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        (layer as! CAGradientLayer).colors = [UIColor.yellow, UIColor.orange, UIColor.blue].map({ $0.cgColor })
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 2000, height: 2000)
    }
}

