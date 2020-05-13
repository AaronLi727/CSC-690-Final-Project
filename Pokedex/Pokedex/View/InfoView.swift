//
//  InfoView.swift
//  Pokedex
//
//  Created by Aaron Li on 5/12/20.
//  Copyright © 2020 Aaron Li. All rights reserved.
//

import UIKit

protocol InfoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?)
}

class InfoView: UIView {
    
    // MARK:  Properties
    
    var delegate: InfoViewDelegate?
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = self.pokemon else { return }
            guard let type = pokemon.type else { return }
            guard let defense = pokemon.defense else { return }
            guard let attack = pokemon.attack else { return }
            guard let id = pokemon.id else { return }
            guard let height = pokemon.height else { return }
            guard let weight = pokemon.weight else { return }
            let weak = pokemon.weak
            imageView.image = pokemon.image
            nameLabel.text = pokemon.name?.capitalized
            
            configureLabel(label: typeLabel, title: "Type", details: type)
            configureLabel(label: defenseLabel, title: "Defense", details: "\(defense)")
            configureLabel(label: heightLabel, title: "Height", details: String(format: "%.1f" + "m", height))
            configureLabel(label: weightLabel, title: "Weight", details: String(format: "%.1f" + "kg", weight))
            configureLabel(label: pokedexIdLabel, title: "ID", details: "\(id)")
            configureLabel(label: attackLabel, title: "Attack", details: "\(attack)")
            configureLabel(label: weakLabel, title: "Weak", details: weak)
            
        
            print( pokemon.evolutionChain)
            print( pokemon.weak)
        }
    }
    
    var tableView: UITableView!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        view.layer.cornerRadius = 5
        nameLabel.center(inView: view)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let defenseLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let pokedexIdLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let weakLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainPink()
        button.setTitle("View More Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewMoreInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK:  Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    @objc func handleViewMoreInfo() {
        guard let pokemon = self.pokemon else { return }
        delegate?.dismissInfoView(withPokemon: pokemon)
    }
    
    // MARK:  Helper Functions
    
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title):  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainPink()]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        label.attributedText = attributedText
    }
    
    func configureViewForInfoController() {
        addSubview(typeLabel)
        typeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(defenseLabel)
        defenseLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let lineView = UIView()
      // let lineView = UIView(frame: CGRect(x: 0, y: 125, width: 400, height: 1.0))
                  lineView.layer.borderWidth = 1.0
                  lineView.layer.borderColor = UIColor.lightGray.cgColor
                 
        addSubview(lineView)
        lineView.anchor(top: typeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
     
        /*let lineView = UIView(frame: CGRect(x: 0, y: 125, width: 400, height: 1.0))
             lineView.layer.borderWidth = 1.0
             lineView.layer.borderColor = UIColor.lightGray.cgColor*/
            
        
        let lineView2 = UIView()
        // let lineView = UIView(frame: CGRect(x: 0, y: 125, width: 400, height: 1.0))
                    lineView2.layer.borderWidth = 1.0
                    lineView2.layer.borderColor = UIColor.lightGray.cgColor
                   
         
        addSubview(heightLabel)
        heightLabel.anchor(top: lineView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(pokedexIdLabel)
        pokedexIdLabel.anchor(top: lineView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        addSubview(lineView2)
                 lineView2.anchor(top: heightLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
        
        addSubview(weightLabel)
               weightLabel.anchor(top: lineView2.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(attackLabel)
        attackLabel.anchor(top: lineView2.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let lineView3 = UIView()
        // let lineView = UIView(frame: CGRect(x: 0, y: 125, width: 400, height: 1.0))
                    lineView3.layer.borderWidth = 1.0
                    lineView3.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(lineView3)
        lineView3.anchor(top: attackLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
        addSubview(weakLabel)
        weakLabel.anchor(top: attackLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    func configureViewComponents() {  //ViewMoreSection
        
        backgroundColor = .white
        self.layer.masksToBounds = true
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(imageView)
        imageView.anchor(top: nameContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(pokedexIdLabel)
        pokedexIdLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
         pokedexIdLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(typeLabel)
        typeLabel.anchor(top: pokedexIdLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(attackLabel)
        attackLabel.anchor(top: typeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
         attackLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(defenseLabel)
        defenseLabel.anchor(top: attackLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        defenseLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(heightLabel)
        heightLabel.anchor(top: defenseLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        heightLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(weightLabel)
        weightLabel.anchor(top: heightLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
          weightLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(weakLabel)
               weakLabel.anchor(top: weightLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                 weakLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(infoButton)
        infoButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 50)
        
    }
    
    
}
