//
//  PokedexController.swift
//  Pokedex
//
//  Created by Aaron Li on 5/10/20.
//  Copyright © 2020 Aaron Li. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PokedexCell"

class PokedexController: UICollectionViewController
{
    //Mark: Properties
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    let infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //Mark: Init
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         
        configureViewComponents()
        fetchPokemon()
    }
    
    //Mark: Selectors
    
    @objc func showSearchBar() {
           configureSearchBar(shouldShow: true)
       }
       
       @objc func handleDismissal() {
           dismissInfoView(pokemon: nil)
       }
    //Mark: API
    
    func fetchPokemon()
    {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
    //Mark: Helper Function
    
    func showPokemonInfoController(withPokemon pokemon: Pokemon)
    {
        let controller = PokemonInfoController()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureSearchBar(shouldShow: Bool) {
        if shouldShow {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        }
        else{
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            collectionView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func dismissInfoView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.infoView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            guard let pokemon = pokemon else {return}
            self.showPokemonInfoController(withPokemon: pokemon)
        }
    }
    
    func configureViewComponents()
    {
        collectionView.backgroundColor = .white //background color
        
        navigationController?.navigationBar.barTintColor = .mainPink() //color of nav bar
        navigationController?.navigationBar.barStyle = .black //color of wifi/time/battery
        //navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationItem.title = "Pokedex"
        
        configureSearchBarButton()
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(gesture)
    }
}

//Mark: UISearchBarDelegate

extension PokedexController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       /* navigationItem.titleView = nil
        configureSearchBarButton()
        inSearchMode = false
        collectionView.reloadData()*/
        configureSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}

//Mark: UICollectionViewDataSource

extension PokedexController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //return pokemon.count //returns how many pokemon are within the json file
        
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokedexCell
        
        //cell.pokemon = pokemon[indexPath.item] //getting element (pokemon) within array
        cell.pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           /*let controller = PokemonInfoController()
           controller.pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
           navigationController?.pushViewController(controller, animated: true)*/
           let pokemons = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
           
           var pokemonEvoArray = [Pokemon]()
           
           if let evoChain = pokemons.evolutionChain
           {
           let evolutionChain = EvolutionChain(evolutionArray: evoChain)
           let evoIds = evolutionChain.evolutionIds
           
           evoIds.forEach{(id) in
               pokemonEvoArray.append(pokemon[id - 1])
           }
           /*pokemonEvoArray.forEach{(pokemon) in
               print(pokemon.name)
           }*/
           
           pokemons.evoArray = pokemonEvoArray
           }
           showPokemonInfoController(withPokemon: pokemons)
           
       }

}

extension PokedexController: UICollectionViewDelegateFlowLayout
{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let width = (view.frame.width - 36) / 3
           return CGSize(width: width, height: width)
       }
}

// MARK:  PokedexCellDelegate

extension PokedexController: PokedexCellDelegate {
    
    func presentInfoView(withPokemon pokemon: Pokemon) {
        
        configureSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(infoView)
        infoView.configureViewComponents()
        infoView.delegate = self
        infoView.pokemon = pokemon
        infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 64, height: 350)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
    }
}

// MARK:  InfoViewDelegate

extension PokedexController: InfoViewDelegate {
    
    func dismissInfoView(withPokemon pokemon: Pokemon?) {
        dismissInfoView(pokemon: pokemon)
    }
}

