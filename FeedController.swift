//
//  ViewController.swift
//  Facebook_Feed
//
//  Created by kitiwat chanluthin on 9/2/18.
//  Copyright © 2018 kitiwat chanluthin. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}



class FeedCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributeText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: "\nDecember 18 \u{2022} Sanf Francisco \u{2022} ", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 155, green: 161, blue: 171)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributeText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributeText.string.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named:"globe")
        attachment.bounds = CGRect(x: 0, y: -1, width: 9, height: 9)
        
        attributeText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributeText
        return label
    }()
    
    let profileImageView:UIImageView = {
       let image = UIImage(named: "mina")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let statusImageView:UIImageView = {
        let image = UIImage(named: "sicario")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let statusTextView:UITextView = {
       let textView = UITextView()
        textView.text = "Oscars Postmortem: A Tribute to Roger Deakins"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let likesCommentLabel:UILabel = {
        let label = UILabel()
        label.text = "488 Likes  10,7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like-icon")
    
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment-icon")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share-icon")
    
    static func buttonForTitle(title:String,imageName:String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named:imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    func setupViews(){
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addConstrainWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView,nameLabel)
        
        addConstrainWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstrainWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstrainWithFormat(format: "H:|-12-[v0]|", views: likesCommentLabel)
        addConstrainWithFormat(format: "H:|-12-[v0]-21-|", views: dividerLineView)
        
        
        addConstrainWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton,commentButton,shareButton)
        
        addConstrainWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstrainWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView,statusTextView,statusImageView,likesCommentLabel,dividerLineView,likeButton)
        
        addConstrainWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstrainWithFormat(format: "V:[v0(44)]|", views: shareButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func rgb(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstrainWithFormat(format:String,views:UIView...){
        var viewDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
        
    }
}
















