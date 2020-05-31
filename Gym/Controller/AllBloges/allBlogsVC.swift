//
//  allBlogsVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class allBlogsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var allBlogesCollection: UICollectionView!
    
    var blogs = [blogsData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        
        allBlogesCollection.delegate = self
        allBlogesCollection.dataSource = self
        
        self.allBlogesCollection.register(UINib.init(nibName: "blogsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        blogsHandelRefresh()
    }
    
    func blogsHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.blogsApi{ (error,success,blogs) in
            if let blogs = blogs{
                self.blogs = blogs.data ?? []
                print(blogs)
                self.allBlogesCollection.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
}

extension allBlogsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = blogsDetialsVC(nibName: "blogsDetialsVC", bundle: nil)
        vc.singleBlogs = blogs[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return blogs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = allBlogesCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? blogsCell {
            cell.configureCell(blogs: blogs[indexPath.row])
            return cell
        }else {
            return blogsCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let screenWidth = allBlogesCollection.frame.width
        
        var width = (screenWidth - 10)/2
        
        width = width < 130 ? 160 : width
        
        return CGSize.init(width: width, height: 200)
    }
    
}

