//
//  ViewController.swift
//  OpenQuizz
//
//  Created by Christophe Bugnon on 27/11/2017.
//  Copyright © 2017 Christophe Bugnon. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var darkBlue : UIColor { return UIColor(red: 70/255, green: 88/255, blue: 111/255, alpha: 1) }
    static var lightBlue : UIColor { return UIColor(red: 75/255, green: 122/255, blue: 187/255, alpha: 1)}
    static var redColor : UIColor { return UIColor(red: 237/255, green: 113/255, blue: 129/255, alpha: 1)}
    static var greenColor : UIColor { return UIColor(red: 189/255, green: 235/255, blue: 143/255, alpha: 1)}
    static var grayColor : UIColor { return UIColor(red: 178/255, green: 183/255, blue: 188/255, alpha: 1)}
}

class ViewController: UIViewController {

    // Let's avoir polluting viewDidLoad
    // {} is referred to as closure, or anon. functions
    
//    let topUIView : UIView = {
//        let newImageView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        newImageView.backgroundColor = .red
//        //This enable layout for our topUIView
//        newImageView.translatesAutoresizingMaskIntoConstraints = false
//        return newImageView
//    }()
    
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var scoreUILabel : UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Balham", size: 30)
        label.text = "0 / 10"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var questionsUILabel : UILabel = {
       let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Balham", size: 23)
        label.numberOfLines = 0
        label.text = "Où se cache donc le Marsupilami ?"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
//    label.center = CGPointMake(160, 284)
//    label.textAlignment = NSTextAlignment.Center
//    label.text = "I'am a test label"
    
    private let newGameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Game", for: .normal)
        button.titleLabel?.font = UIFont(name: "Balham", size: 23)
        button.backgroundColor = UIColor.lightBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    private let questionUIView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.grayColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconeQuestions : UIImageView = {
        let image = UIImage(named: "Icon Error")
        let imageView = UIImageView(image: image!)
//        IMG_view.image=[UIImage imageNamed:@"Loading_50x50.png"];
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

//    let bearImageView: UIImageView = {
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
//        // this enables autolayout for our imageView
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//        private let previousButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("PREV", for: .normal)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//            button.setTitleColor(.gray, for: .normal)
//            return button
    
//    let middleTopUIView : UIView = {
//        let newImageView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        newImageView.backgroundColor = .green
//        // This enable layout for our topUIView
//        newImageView.translatesAutoresizingMaskIntoConstraints = false
//        return newImageView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Here's our entry point into our app
        //        view.addSubview(topUIView)
        
        view.backgroundColor = UIColor.darkBlue
        view.addSubview(newGameButton)
        newGameButton.addSubview(activityIndicator)
        view.addSubview(scoreUILabel)
        view.addSubview(questionUIView)
        questionUIView.addSubview(questionsUILabel)
        questionUIView.addSubview(iconeQuestions)
        
        setupLayout()
        
    }

    
    private func setupLayout() {
        
        iconeQuestions.centerXAnchor.constraint(equalTo: questionUIView.centerXAnchor).isActive = true
        iconeQuestions.bottomAnchor.constraint(equalTo: questionUIView.bottomAnchor, constant: -8).isActive = true
//        iconeQuestions.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        iconeQuestions.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        questionsUILabel.topAnchor.constraint(equalTo: questionUIView.topAnchor, constant: 8).isActive = true
        questionsUILabel.bottomAnchor.constraint(equalTo: questionUIView.bottomAnchor, constant: 8).isActive = true
        questionsUILabel.leadingAnchor.constraint(equalTo: questionUIView.leadingAnchor, constant: 8).isActive = true
        questionsUILabel.trailingAnchor.constraint(equalTo: questionUIView.trailingAnchor, constant: 8).isActive = true
        
        questionUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionUIView.widthAnchor.constraint(equalToConstant: 245).isActive = true
        questionUIView.heightAnchor.constraint(equalToConstant: 245).isActive = true
        questionUIView.bottomAnchor.constraint(equalTo: scoreUILabel.topAnchor, constant: -8).isActive = true
        
        scoreUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreUILabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 273).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: newGameButton.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: newGameButton.centerXAnchor).isActive = true
        
        newGameButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        newGameButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
    }
    
}

