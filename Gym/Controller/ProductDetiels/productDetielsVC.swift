//
//  productDetielsVC.swift
//  Gym
//
//  Created by Ahmed farid on 5/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView

class productDetielsVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var bageControl: UIPageControl!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var smallDec: UILabel!
    @IBOutlet weak var moreInfo: costomButton!
    @IBOutlet weak var reviewBTN: costomButton!
    @IBOutlet weak var moreDesc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var faveBtn: UIButton!
    @IBOutlet weak var plusQtyBTN: UIButton!
    @IBOutlet weak var minQtyBTN: UIButton!
    @IBOutlet weak var qtyText: UITextField!
    @IBOutlet weak var discoView: UIView!
    @IBOutlet weak var reviewTabelView: UITableView!
    @IBOutlet weak var tabelViewHight: NSLayoutConstraint!
    @IBOutlet weak var moreDesHight: UILabel!
    @IBOutlet weak var moreDescHight2: NSLayoutConstraint!
    @IBOutlet weak var sizeCollection: UICollectionView!
    
    
    var SingleproductData: productData?
    var slider = [String]()
    var reviews = [Review]()
    var sizes = [ProductSize]()
    var timer : Timer?
    var currentIndex = 0
    var numberOflines = 0
    var isFav:  Bool?
    var qty = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: false, cart: true, back: true)
        
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        
        self.productImagesCollectionView.register(UINib.init(nibName: "productImageCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        reviewTabelView.delegate = self
        reviewTabelView.dataSource = self
        
        
        
        reviewTabelView.rowHeight = UITableView.automaticDimension
        reviewTabelView.estimatedRowHeight = UITableView.automaticDimension
        
        self.reviewTabelView.register(UINib.init(nibName: "reviewsCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        
        sizeCollection.delegate = self
        sizeCollection.dataSource = self
        
        self.sizeCollection.register(UINib.init(nibName: "productSizesCell", bundle: nil), forCellWithReuseIdentifier:"cell")
        
        startTimer()
        //customFaveBtn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpView()

    }
    
    func customFaveBtn() {
        if isFav == true {
            faveBtn.setImage(UIImage(named: "Group 1"), for: .normal)
        }else {
            faveBtn.setImage(UIImage(named: "Group 2"), for: .normal)
        }
    }
    
    func setUpView() {
        slider = SingleproductData?.images ?? []
        sizes = SingleproductData?.sizes ?? []
        self.bageControl.numberOfPages = self.slider.count
        self.bageControl.currentPage = 0
        self.productImagesCollectionView.reloadData()
        isFav = SingleproductData?.isFavorite
        customFaveBtn()
        name.text = SingleproductData?.title
        smallDec.text = SingleproductData?.datumDescription?.html2String
        rate.rating = Double(SingleproductData?.rate ?? 0)
        moreDesc.text = SingleproductData?.more?.html2String
        numberOflines = moreDesc.numberOfVisibleLines
        //print("sssssss\(SingleproductData?.more?.html2String)")
        self.moreDescHight2.constant = (CGFloat(numberOflines) * (22.5))
        self.tabelViewHight.constant = (CGFloat(numberOflines) * (22.5))
        moreDesc.isHidden = false
        let Totalprice = NSLocalizedString("Total price", comment: "")
        price.text = "\(Totalprice) \(SingleproductData?.sizes?.first?.price ?? "") \(helperLogin.getLangData().mainCurancys ?? "")"
        if SingleproductData?.discount == 0{
            discount.isHidden = true
            discoView.isHidden = true
        }else {
            discount.isHidden = false
            discoView.isHidden = false
            discount.text = "\(SingleproductData?.discount ?? 0) \(helperLogin.getLangData().mainCurancys ?? "")"
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
            self.productImagesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.productImagesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    func addToFavOrRemove(Url: String) {
        favoriteApi.addFavorite(url: Url, productId: "\(SingleproductData?.id ?? 0)"){ (error, success, message) in
            if success {
                if message?.status == true {
                    if self.isFav == false {
                        self.isFav = true
                        self.customFaveBtn()
                        self.stopAnimating()
                    }else if self.isFav == true {
                        self.isFav = false
                        self.customFaveBtn()
                        self.stopAnimating()
                    }
                    self.stopAnimating()
                    let AddtoFavorite = NSLocalizedString("Add to Favorite", comment: "")
                    self.showAlert(title: AddtoFavorite, message: message?.data ?? "")
                }else {
                    let AddtoFavorite = NSLocalizedString("Add to Favorite", comment: "")
                    let message = NSLocalizedString("Check your network", comment: "")
                    self.showAlert(title: AddtoFavorite, message: message)
                    self.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func minQtyAction(_ sender: Any) {
        qty = qty - 1
        let priceInt = Int(SingleproductData?.sizes?.first?.price ?? "") ?? 0
        let Totalprice = NSLocalizedString("Total price", comment: "")
        self.price.text = "\(Totalprice) \(priceInt * self.qty) \(helperLogin.getLangData().mainCurancys ?? "")"
        self.discount.text = "\((SingleproductData?.discount ?? 0) * qty) \(helperLogin.getLangData().mainCurancys ?? "")"
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
    }
    
    @IBAction func pluseQtyAction(_ sender: Any) {
        qty = qty + 1
        let priceInt = Int(SingleproductData?.sizes?.first?.price ?? "") ?? 0
        let Totalprice = NSLocalizedString("Total price", comment: "")
        self.price.text = "\(Totalprice) \(priceInt * self.qty) \(helperLogin.getLangData().mainCurancys ?? "")"
        self.discount.text = "\((SingleproductData?.discount ?? 0) * qty) \(helperLogin.getLangData().mainCurancys ?? "")"
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
        
    }
    
    
    @IBAction func faveBTNAction(_ sender: Any) {
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        if isFav == true {
            addToFavOrRemove(Url: "removeFromFavorite")
        }else {
            addToFavOrRemove(Url: "addToFavorite")
        }
    }
    
    @IBAction func reviewsBTNAction(_ sender: Any) {
        moreInfo.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        reviewBTN.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        
        moreInfo.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        reviewBTN.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.moreDescHight2.constant = (300)
        self.tabelViewHight.constant = (300)
        
        
        self.moreDesc.isHidden = true
        print("xxx")
        homeApi.getReviews(productID: "\(SingleproductData?.id ?? 0)"){ (error,success,reviews) in
            if let reviews = reviews{
                self.reviews = reviews.data?.reviews ?? []
                print(reviews)
                self.reviewTabelView.reloadData()
                self.moreDesc.isHidden = true
                self.reviewTabelView.isHidden = false
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    @IBAction func getInfoBTNAction(_ sender: Any) {
        
        reviewBTN.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        moreInfo.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        
        reviewBTN.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        moreInfo.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        self.moreDescHight2.constant = (CGFloat(numberOflines) * (22.5))
        self.tabelViewHight.constant = (CGFloat(numberOflines) * (22.5))
        
        self.reviewTabelView.isHidden = true
        self.moreDesc.isHidden = false
        
        
    }
    
    @IBAction func addCartBTNAction(_ sender: Any) {
        let Loading = NSLocalizedString("Loading...", comment: "")
        startAnimating(CGSize(width: 45, height: 45), message: Loading,type: .ballSpinFadeLoader, color: .black, textColor: .white)
        cartApi.addCarts(productId: "\(SingleproductData?.sizes?.first?.id ?? 0)", quantity: "\(qty)"){ (error, success, message) in
            if success {
                self.stopAnimating()
                let Addcart = NSLocalizedString("Add cart", comment: "")
                self.showAlert(title: Addcart, message: message?.data ?? "")
            }else {
                let Addcart = NSLocalizedString("Add cart", comment: "")
                let message = NSLocalizedString("Check your network", comment: "")
                self.showAlert(title: Addcart, message: message)
                self.stopAnimating()
            }
        }
    }
}



extension productDetielsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("print")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productImagesCollectionView{
             return slider.count
        }else {
            return sizes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productImagesCollectionView{
            if let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productImageCell {
                cell.configureCell(images: slider[indexPath.row])
                return cell
            }else {
                return productImageCell()
            }
        }else {
            if let cell = sizeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productSizesCell {
                cell.configureCell(product: sizes[indexPath.row])
                return cell
            }else {
                return productSizesCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == productImagesCollectionView{
        return CGSize(width: productImagesCollectionView.frame.size.width, height: productImagesCollectionView.frame.size.height)
        }else {
            return CGSize(width: sizeCollection.frame.size.width/3, height: sizeCollection.frame.size.height - 12)
        }
    }
    
}


extension productDetielsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = reviewTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? reviewsCell {
            cell.configureCell(product: reviews[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return reviewsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
