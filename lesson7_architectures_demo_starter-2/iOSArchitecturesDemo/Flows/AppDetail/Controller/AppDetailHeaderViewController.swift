//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 11/12/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {
    private let app: ITunesApp
    
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        downloadImage()
        
        appDetailHeaderView.titleLabel.text = app.appName
        appDetailHeaderView.subTitleLabel.text = app.company
        appDetailHeaderView.ratingLabel.text = app.averageRating.flatMap { "\($0)" }
    }
    
    private func downloadImage() {
        guard let url = app.iconUrl else { return }
        imageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.appDetailHeaderView.imageView.image = image
            }
            
        }
    }
    
}
