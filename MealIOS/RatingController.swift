//
//  RatingController.swift
//  MealIOS
//
//  Created by maisapride8 on 09/06/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit

class RatingController: UIView {
    
    //MARK: Properties.
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    let starCount = 5
    let spacing = 5
    
    
    // MARK: Initialization.
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        
        for _ in 0 ..< starCount
        {
            let button  = UIButton()
        //let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(filledStar, forState: [.Highlighted,.Selected])
       // button.backgroundColor = UIColor.brownColor()
        
        button.addTarget(self, action: #selector(RatingController.ratingButtonTapped(_:)), forControlEvents:.TouchDown)
        
        self.ratingButtons += [button]
            
        addSubview(button)
            
        }
    }
    
    override func layoutSubviews()
    {
        
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerate()
        {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize
    {
        let stars = 5
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * stars) + (spacing * (stars - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    
    //MARK: Button Action.
    func ratingButtonTapped(button: UIButton)
    {
            
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates()
    {
        for (index, button) in ratingButtons.enumerate()
        {
            button.selected = index < rating
        }
    }
}
