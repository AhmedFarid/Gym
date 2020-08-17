//
//  homeVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH

class homeVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bageControl: UIPageControl!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var newArrivalsCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var blogsCollectionView: UICollectionView!
    @IBOutlet weak var dellsOfDayCollection: UICollectionView!
    @IBOutlet weak var socendBannerCollecctionView: UICollectionView!
    
    
    var slider = [sliderData]()
    var featuredData = [productData]()
    var newArrivals = [productData]()
    var bestSelling = [productData]()
    var dellProduct = [productData]()
    var dellProducts = [dellData]()
    var banners = [bannerData]()
    var blogs = [blogsData]()
    var timer : Timer?
    var currentIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        self.bannerCollectionView.register(UINib.init(nibName: "sliderCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        socendBannerCollecctionView.delegate = self
        socendBannerCollecctionView.dataSource = self
        
        self.socendBannerCollecctionView.register(UINib.init(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        
        self.featuredCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        dellsOfDayCollection.delegate = self
        dellsOfDayCollection.dataSource = self
        
        self.dellsOfDayCollection.register(UINib.init(nibName: "dealsOfDayCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        newArrivalsCollectionView.delegate = self
        newArrivalsCollectionView.dataSource = self
        
        self.newArrivalsCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        bestSellingCollectionView.delegate = self
        bestSellingCollectionView.dataSource = self
        
        self.bestSellingCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        blogsCollectionView.delegate = self
        blogsCollectionView.dataSource = self
        
        self.blogsCollectionView.register(UINib.init(nibName: "blogsCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
        ////        sliderHandelRefresh()
        ////        featuradHandelRefresh(Url: "/featuredProducts")
        ////        newArrivalsHandelRefresh(Url: "/newArrivalProducts")
        ////        bestSellingHandelRefresh(Url: "/bestSellingProducts")
        ////        dellOfDayHandelRefresh()
        ////        blogsHandelRefresh()
        //        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sliderHandelRefresh()
        featuradHandelRefresh(Url: "/featuredProducts")
        newArrivalsHandelRefresh(Url: "/newArrivalProducts")
        bestSellingHandelRefresh(Url: "/bestSellingProducts")
        dellOfDayHandelRefresh()
        blogsHandelRefresh()
        bannerHandelRefresh()
        setUpNav(logo: true, menu: true, cart: true, back: false)
        setUpNavColore(false)
        startTimer()
        
    }
    
    func sliderHandelRefresh(){
        homeApi.sliderApi{ (error,success,slider) in
            if let slider = slider{
                self.slider = slider.data ?? []
                print(slider)
                self.bageControl.numberOfPages = self.slider.count
                self.bageControl.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
        }
    }
    
    func bannerHandelRefresh(){
        homeApi.bannerApi{ (error,success,banners) in
            if let banners = banners{
                self.banners = banners.data ?? []
                self.bannerCollectionView.semanticContentAttribute = .forceLeftToRight
                print(banners)
                self.socendBannerCollecctionView.reloadData()
            }
        }
    }
    
    
    
    func featuradHandelRefresh(Url: String){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.product(url: Url){ (error,success,featuredData) in
            if let featuredData = featuredData{
                self.featuredData = featuredData.data ?? []
                print(featuredData)
                if helperLogin.getLangData().mainLangs == "ar" {
                    self.featuredData.reverse()
                }
                self.featuredCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func newArrivalsHandelRefresh(Url: String){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.product(url: Url){ (error,success,newArrivals) in
            if let newArrivals = newArrivals{
                self.newArrivals = newArrivals.data ?? []
                print(newArrivals)
                if helperLogin.getLangData().mainLangs == "ar" {
                    self.newArrivals.reverse()
                }
                self.newArrivalsCollectionView.reloadData()
            }
        }
    }
    
    func bestSellingHandelRefresh(Url: String){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.product(url: Url){ (error,success,bestSelling) in
            if let bestSelling = bestSelling{
                self.bestSelling = bestSelling.data ?? []
                print(bestSelling)
                if helperLogin.getLangData().mainLangs == "ar" {
                    self.bestSelling.reverse()
                }
                self.bestSellingCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func blogsHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.blogsApi{ (error,success,blogs) in
            if let blogs = blogs{
                self.blogs = blogs.data ?? []
                print(blogs)
                if helperLogin.getLangData().mainLangs == "ar" {
                    self.blogs.reverse()
                }
                self.blogsCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func dellOfDayHandelRefresh(){
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        homeApi.dellProduct{ (error,success,dell) in
            if let dell = dell?.data{
                self.dellProduct.append(productData(id: dell.id, title: dell.title, datumDescription: dell.dataDescription, more: dell.more,  discount: dell.discount, rate: dell.rate, isFavorite: dell.isFavorite, images: dell.images, sizes: dell.sizes))
                self.dellProducts.append(dellData(id: dell.id
                    , title: dell.title, dataDescription: dell.dataDescription, more: dell.more, discount: dell.discount, rate: dell.rate, day: dell.day, hour: dell.hour, min: dell.min, isFavorite: dell.isFavorite, images: dell.images, sizes: dell.sizes, reviews: dell.reviews))
                self.dellsOfDayCollection.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    
    
    
}

extension homeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView {
            print("xx")
        }else if collectionView == socendBannerCollecctionView {
            print("x")
        }else if collectionView == bestSellingCollectionView {
            let vc = productDetielsVC(nibName: "productDetielsVC", bundle: nil)
            vc.SingleproductData = bestSelling[indexPath.row]
            
            self.navigationController!.pushViewController(vc, animated: true)
        }else if collectionView == newArrivalsCollectionView {
            let vc = productDetielsVC(nibName: "productDetielsVC", bundle: nil)
            vc.SingleproductData = newArrivals[indexPath.row]
            self.navigationController!.pushViewController(vc, animated: true)
        }else if collectionView ==  blogsCollectionView {
            let vc = blogsDetialsVC(nibName: "blogsDetialsVC", bundle: nil)
            vc.singleBlogs = blogs[indexPath.row]
            self.navigationController!.pushViewController(vc, animated: true)
        }else if collectionView == dellsOfDayCollection {
            let vc = productDetielsVC(nibName: "productDetielsVC", bundle: nil)
            vc.SingleproductData = dellProduct[indexPath.row]
            self.navigationController!.pushViewController(vc, animated: true)
        }else {
            let vc = productDetielsVC(nibName: "productDetielsVC", bundle: nil)
            vc.SingleproductData = featuredData[indexPath.row]
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return slider.count
        }else if collectionView == socendBannerCollecctionView {
            return banners.count
        } else if collectionView == bestSellingCollectionView {
            return bestSelling.count
        }else if collectionView == newArrivalsCollectionView {
            return newArrivals.count
        }else if collectionView ==  blogsCollectionView {
            return blogs.count
        }else if collectionView == dellsOfDayCollection {
            return dellProducts.count
        }else {
            return featuredData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? sliderCell {
                cell.configureCell(images: slider[indexPath.row])
                
                return cell
            }else {
                return sliderCell()
            }
        }else if collectionView == socendBannerCollecctionView {
            if let cell = socendBannerCollecctionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
                cell.configureCell(images: banners[indexPath.row])
                
                return cell
            }else {
                return bannerCell()
            }
        } else if collectionView == bestSellingCollectionView {
            if let cell = bestSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productsCell {
                cell.configureCell(product:  bestSelling[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                return cell
            }else {
                return productsCell()
            }
        }else if collectionView == newArrivalsCollectionView {
            if let cell = newArrivalsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productsCell {
                cell.configureCell(product:  newArrivals[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                return cell
            }else {
                return productsCell()
            }
        }else if collectionView == blogsCollectionView {
            if let cell = blogsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? blogsCell {
                cell.configureCell(blogs: blogs[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                return cell
            }else {
                return blogsCell()
            }
        }else if collectionView == dellsOfDayCollection {
            if let cell = dellsOfDayCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? dealsOfDayCell {
                cell.configureCell(product:  dellProducts[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                return cell
            }else {
                return dealsOfDayCell()
            }
        }else {
            if let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productsCell {
                cell.configureCell(product:  featuredData[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                
                return cell
            }else {
                return productsCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == bannerCollectionView {
            return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
        }else if collectionView == socendBannerCollecctionView {
            return CGSize(width: socendBannerCollecctionView.frame.size.width / 3, height: socendBannerCollecctionView.frame.size.height)
        }else if collectionView == dellsOfDayCollection {
            return CGSize(width: dellsOfDayCollection.frame.size.width, height: dellsOfDayCollection.frame.size.height)
        }else {
            return CGSize(width: bannerCollectionView.frame.size.width / 1.8, height: bannerCollectionView.frame.size.height)
        }
    }
    
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        }else {
            if textAlignment == .natural {
                self.textAlignment = .left
            }
        }
    }
}
